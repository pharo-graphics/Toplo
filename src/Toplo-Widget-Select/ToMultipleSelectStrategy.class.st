Class {
	#name : #ToMultipleSelectStrategy,
	#superclass : #ToSelectStrategy,
	#instVars : [
		'headerNodeHolders'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #private }
ToMultipleSelectStrategy >> adaptNodeContainerLayout [

	select headerNodeContainer layout: self headerNodeContainerLayout
]

{ #category : #'accessing nodes' }
ToMultipleSelectStrategy >> addAllDataNodes: aNodeCollection [

	aNodeCollection do: [ :n | self addDataNode: n ]
]

{ #category : #'accessing nodes' }
ToMultipleSelectStrategy >> addDataNode: aNode [

	select headerNodeContainer addChild: aNode before: self textInputElement
]

{ #category : #initialization }
ToMultipleSelectStrategy >> buildHeaderNodeContainer: aSelectHeaderNodeContainer [

	aSelectHeaderNodeContainer
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].
	" The textField is added whatever the mode to draw the placeholder text if any.
	In case of read-only mode, the textfield is set as read-only by the mode "
	textInputElement := ToSelectTextInputElement new.
	textInputElement onInstalledIn: select.
	textInputElement hFitContent.
	aSelectHeaderNodeContainer addChild: textInputElement
]

{ #category : #'accessing nodes' }
ToMultipleSelectStrategy >> headerDataNodesDo: aBlock [

	self headerNodeHolders do: [ :holder |	aBlock value: holder node ].
]

{ #category : #'instance creation' }
ToMultipleSelectStrategy >> headerNodeContainerClass [

	^ ToMultipleSelectHeaderNodeContainerElement
]

{ #category : #private }
ToMultipleSelectStrategy >> headerNodeContainerLayout [

	^ self nodeWrapping
		ifTrue: [ BlFlowLayout horizontal ]
		ifFalse: [ BlLinearLayout horizontal ]
]

{ #category : #'accessing nodes' }
ToMultipleSelectStrategy >> headerNodeHolders [

	^ headerNodeHolders
]

{ #category : #initialization }
ToMultipleSelectStrategy >> initialize [

	super initialize.
	headerNodeHolders := OrderedCollection new
	
]

{ #category : #testing }
ToMultipleSelectStrategy >> isMultipleSelection [

	^ true
]

{ #category : #accessing }
ToMultipleSelectStrategy >> nodeWrapping [

	^ select nodeWrapping
]

{ #category : #'api - hooks' }
ToMultipleSelectStrategy >> onInstalledIn: aSelect [

	aSelect listElement selectionMode:
		(ToListMultipleSelectionMode new operator:
			 (ToPrimarySelectionModelOperator new selectionModel: aSelect listElement selectionModel)).
	super onInstalledIn: aSelect
]

{ #category : #'api - hooks' }
ToMultipleSelectStrategy >> onUninstalledIn: aSelect [

	self headerDataNodesDo: [ :node |
		node onUninstalledIn: select.
		node removeFromParent ].
	self headerNodeHolders reset.
	super onUninstalledIn: select
]

{ #category : #private }
ToMultipleSelectStrategy >> refreshHeaderNodeContainer [

	| nodes previousHolders |
	" first remove all data nodes "
	self headerDataNodesDo: [ :node | node removeFromParent ].
	previousHolders := self headerNodeHolders copy.
	self headerNodeHolders reset.
	" then rebuild current nodes according to current selection "
	nodes := select selectionModel selectedIndexesCollect: [ :idx |
		         | node prevHolder selectedData |
		         prevHolder := previousHolders
			                       detect: [ :h | h position = idx ]
			                       ifNone: [  ].
		         node := prevHolder
			                 ifNil: [ select headerNodeContainer newHeaderNode ]
			                 ifNotNil: [ :h | h node ].
		         prevHolder
			         ifNil: [
				         selectedData := select dataAccessor at: idx.
				         node selectHolder
					         position: idx;
					         data: selectedData.
				         self headerNodeBuilder
					         value: node
					         value: node selectHolder ]
			         ifNotNil: [ previousHolders remove: prevHolder ].
		         self headerNodeHolders add: node selectHolder.
		         node ].

	previousHolders do: [ :h | h node onUninstalledIn: select ].
	self addAllDataNodes: nodes
]

{ #category : #accessing }
ToMultipleSelectStrategy >> textInputElement [

	^ select headerNodeContainer textInputElement 
]
