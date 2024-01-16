Class {
	#name : #ToMultiSelectStrategy,
	#superclass : #ToSelectStrategy,
	#instVars : [
		'nodeWrapping',
		'maxCount'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'accessing nodes' }
ToMultiSelectStrategy >> addAllDataNodes: aNodeCollection [

	aNodeCollection do: [ :n | self addDataNode: n ]
]

{ #category : #'accessing nodes' }
ToMultiSelectStrategy >> addDataNode: aNode [

	select nodeContainer addChild: aNode before: select textField
]

{ #category : #initialization }
ToMultiSelectStrategy >> buildNodeContainer: anElement [

	anElement
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].
	select mode configureMultiSelectNodeContainer: anElement

]

{ #category : #initialization }
ToMultiSelectStrategy >> defaultNodeBuilder [

	^ [ :aSelectNode :aNodeHolder |
	  aSelectNode beRemovable.
	  aSelectNode middleContainer addChild:
		  (ToLabel text: aNodeHolder data asString) ]
]

{ #category : #initialization }
ToMultiSelectStrategy >> defaultNodeClass [ 

	^ ToMultiSelectNode
]

{ #category : #initialization }
ToMultiSelectStrategy >> defaultNodeWrapping [

	^ true
]

{ #category : #initialization }
ToMultiSelectStrategy >> initialize [

	super initialize.
	maxCount := SmallInteger maxVal.
	nodeWrapping := self defaultNodeWrapping.

	
]

{ #category : #testing }
ToMultiSelectStrategy >> isMultiSelection [

	^ true
]

{ #category : #accessing }
ToMultiSelectStrategy >> maxCount [

	^ maxCount
]

{ #category : #accessing }
ToMultiSelectStrategy >> maxCount: aNumber [

	maxCount := aNumber
]

{ #category : #private }
ToMultiSelectStrategy >> nodeContainerLayout [

	^ nodeWrapping
		ifTrue: [ BlFlowLayout horizontal ]
		ifFalse: [ BlLinearLayout horizontal ]
]

{ #category : #accessing }
ToMultiSelectStrategy >> nodeWrapping [

	^ nodeWrapping 
]

{ #category : #accessing }
ToMultiSelectStrategy >> nodeWrapping: aBoolean [

	nodeWrapping = aBoolean ifTrue: [ ^ self ].
	nodeWrapping := aBoolean.
	self onNodeWrappingChange.
]

{ #category : #'api - hooks' }
ToMultiSelectStrategy >> onInstalledIn: aSelect [

	super onInstalledIn: aSelect.
	aSelect listElement selectionStrategy beMultipleSelection
]

{ #category : #private }
ToMultiSelectStrategy >> onNodeWrappingChange [

	select nodeContainer layout: self nodeContainerLayout
]

{ #category : #enumerating }
ToMultiSelectStrategy >> refreshNodeContainer [

	| nodes |

	" first remove all data nodes "
	self dataNodesDo: [ :node | node removeFromParent ].
	self nodeHolders reset.
	" then rebuild current nodes according to current selection "
	nodes := select selectionModel indices collect: [ :idx |
		         | node holder selectedData |
		         node := self newNode.
		         holder := self newNodeHolder.
		         node selectHolder: holder.
		         self nodeHolders add: holder.
		         selectedData := select data at: idx.
		         holder
			         node: node;
			         position: idx;
			         select: select;
			         data: selectedData.
		         self nodeBuilder value: node value: holder.
		         node ].
	self addAllDataNodes: nodes
]
