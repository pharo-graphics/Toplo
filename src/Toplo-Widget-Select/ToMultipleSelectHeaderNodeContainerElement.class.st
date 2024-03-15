Class {
	#name : #ToMultipleSelectHeaderNodeContainerElement,
	#superclass : #ToSelectHeaderNodeContainerElement,
	#instVars : [
		'textInputElement',
		'headerNodeHolders'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #adding }
ToMultipleSelectHeaderNodeContainerElement >> addAllDataNodes: aNodeCollection [

	aNodeCollection do: [ :n | self addDataNode: n ]
]

{ #category : #adding }
ToMultipleSelectHeaderNodeContainerElement >> addDataNode: aNode [

	self addChild: aNode before: self textInputElement
]

{ #category : #accessing }
ToMultipleSelectHeaderNodeContainerElement >> defaultHeaderNodeBuilder [

	^ [ :aSelectNode :aNodeHolder |
	  aSelectNode beRemovable.
	  aSelectNode middleContainer addChild:
		  (ToLabel text: aNodeHolder data asString) ]
]

{ #category : #accessing }
ToMultipleSelectHeaderNodeContainerElement >> defaultHeaderNodeClass [ 

	^ ToMultipleSelectHeaderNode
]

{ #category : #enumerating }
ToMultipleSelectHeaderNodeContainerElement >> headerDataNodesDo: aBlock [

	self headerNodeHolders do: [ :holder |	aBlock value: holder node ].
]

{ #category : #enumerating }
ToMultipleSelectHeaderNodeContainerElement >> headerNodeHolders [

	^ headerNodeHolders ifNil: [
		  headerNodeHolders := OrderedCollection new ]
]

{ #category : #'api - hooks' }
ToMultipleSelectHeaderNodeContainerElement >> onInstalledIn: aSelect [

	super onInstalledIn: aSelect.
	self layout: (aSelect nodeWrapping
			 ifTrue: [ BlFlowLayout horizontal ]
			 ifFalse: [ BlLinearLayout horizontal ]).
	self
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].
	" The textField is added whatever the mode to draw the placeholder text if any.
	In case of read-only mode, the textfield is set as read-only by the mode "
	textInputElement := ToSelectTextInputElement new.
	textInputElement onInstalledIn: select.
	textInputElement hFitContent.
	self addChild: textInputElement.
	self initializeFakeNode
]

{ #category : #accessing }
ToMultipleSelectHeaderNodeContainerElement >> onNodeWrappingChange [

	self layout: (select nodeWrapping
			 ifTrue: [ BlFlowLayout horizontal ]
			 ifFalse: [ BlLinearLayout horizontal ])
]

{ #category : #'api - hooks' }
ToMultipleSelectHeaderNodeContainerElement >> onUninstalledIn: aSelect [

	self headerDataNodesDo: [ :node |
		node onUninstalledIn: select.
		node removeFromParent ].
	textInputElement onUninstalledIn: select.
	textInputElement removeFromParent.
	textInputElement := nil.
	self headerNodeHolders reset.
	fakeNode onUninstalledIn: select.
	fakeNode removeFromParent.
	fakeNode := nil.
	super onUninstalledIn: aSelect.

]

{ #category : #accessing }
ToMultipleSelectHeaderNodeContainerElement >> refresh [

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
			                 ifNil: [ self newHeaderNode ]
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
ToMultipleSelectHeaderNodeContainerElement >> textInputElement [ 

	^ textInputElement 
]
