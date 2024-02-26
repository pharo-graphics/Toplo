Class {
	#name : #ToMultipleSelectStrategy,
	#superclass : #ToSelectStrategy,
	#instVars : [
		'nodeWrapping',
		'headerNodeHolders',
		'textInputElement'
	],
	#category : #'Toplo-Widget-Select-Core'
}

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

{ #category : #initialization }
ToMultipleSelectStrategy >> defaultHeaderNodeBuilder [

	^ [ :aSelectNode :aNodeHolder |
	  aSelectNode beRemovable.
	  aSelectNode middleContainer addChild:
		  (ToLabel text: aNodeHolder data asString) ]
]

{ #category : #initialization }
ToMultipleSelectStrategy >> defaultHeaderNodeClass [ 

	^ ToMultipleSelectHeaderNode
]

{ #category : #initialization }
ToMultipleSelectStrategy >> defaultNodeWrapping [

	^ true
]

{ #category : #'accessing nodes' }
ToMultipleSelectStrategy >> headerDataNodesDo: aBlock [

	self headerNodeHolders do: [ :holder |	aBlock value: holder node ].
]

{ #category : #private }
ToMultipleSelectStrategy >> headerNodeContainerLayout [

	^ nodeWrapping
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
	headerNodeHolders := OrderedCollection new.
	nodeWrapping := self defaultNodeWrapping.

	
]

{ #category : #testing }
ToMultipleSelectStrategy >> isMultipleSelection [

	^ true
]

{ #category : #accessing }
ToMultipleSelectStrategy >> nodeWrapping [

	^ nodeWrapping 
]

{ #category : #accessing }
ToMultipleSelectStrategy >> nodeWrapping: aBoolean [

	nodeWrapping = aBoolean ifTrue: [ ^ self ].
	nodeWrapping := aBoolean.
	self onNodeWrappingChange.
]

{ #category : #'api - hooks' }
ToMultipleSelectStrategy >> onInstalledIn: aSelect [

	aSelect listElement selectionMode:
		(ToListMultipleSelectionMode new operator:
			 (ToPrimarySelectionModelOperator new selectionModel: aSelect listElement selectionModel)).
	aSelect listElement uninstallSelectionModeShortcuts.
	super onInstalledIn: aSelect
]

{ #category : #private }
ToMultipleSelectStrategy >> onNodeWrappingChange [

	select headerNodeContainer layout: self headerNodeContainerLayout
]

{ #category : #'api - hooks' }
ToMultipleSelectStrategy >> onUninstalledIn: aSelect [

	self headerDataNodesDo: [ :node |
		node onUninstalledIn: select.
		node removeFromParent ].
	self headerNodeHolders reset.
	textInputElement := nil.
	super onUninstalledIn: select
]

{ #category : #private }
ToMultipleSelectStrategy >> refreshHeaderNodeContainer [

	| nodes |
	" first remove all data nodes "
	self headerDataNodesDo: [ :node |
		node onUninstalledIn: select.
		node removeFromParent ].
	self headerNodeHolders reset.
	"select selection indices traceCr."
	" then rebuild current nodes according to current selection "
	nodes := select selectionModel selectedIndexes collect: [ :idx |
		         | node selectedData |
		         node := self newHeaderNode.
		         self headerNodeHolders add: node selectHolder.
		         selectedData := select dataAccessor at: idx.
		         node selectHolder
			         position: idx;
			         data: selectedData.
		         self headerNodeBuilder value: node value: node selectHolder.
		         node ].
	self addAllDataNodes: nodes
]

{ #category : #accessing }
ToMultipleSelectStrategy >> textInputElement [

	^ textInputElement 
]
