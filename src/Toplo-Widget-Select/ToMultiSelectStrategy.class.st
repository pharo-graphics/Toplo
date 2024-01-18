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

	select headerNodeContainer addChild: aNode before: select inputTextField
]

{ #category : #initialization }
ToMultiSelectStrategy >> buildHeaderNodeContainer: anElement [

	anElement
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].
	select mode configureMultiSelectNodeContainer: anElement

]

{ #category : #initialization }
ToMultiSelectStrategy >> defaultHeaderNodeBuilder [

	^ [ :aSelectNode :aNodeHolder |
	  aSelectNode beRemovable.
	  aSelectNode middleContainer addChild:
		  (ToLabel text: aNodeHolder data asString) ]
]

{ #category : #initialization }
ToMultiSelectStrategy >> defaultHeaderNodeClass [ 

	^ ToMultiSelectHeaderNode
]

{ #category : #initialization }
ToMultiSelectStrategy >> defaultNodeWrapping [

	^ true
]

{ #category : #'accessing nodes' }
ToMultiSelectStrategy >> headerDataNodesDo: aBlock [

	self headerNodeHolders do: [ :holder |	aBlock value: holder node ].
]

{ #category : #private }
ToMultiSelectStrategy >> headerNodeContainerLayout [

	^ nodeWrapping
		ifTrue: [ BlFlowLayout horizontal ]
		ifFalse: [ BlLinearLayout horizontal ]
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

{ #category : #private }
ToMultiSelectStrategy >> onNodeWrappingChange [

	select headerNodeContainer layout: self headerNodeContainerLayout
]

{ #category : #enumerating }
ToMultiSelectStrategy >> refreshHeaderNodeContainer [

	| nodes |

	" first remove all data nodes "
	self headerDataNodesDo: [ :node | node removeFromParent ].
	self headerNodeHolders reset.
	" then rebuild current nodes according to current selection "
	nodes := select selectionModel indices collect: [ :idx |
		         | node holder selectedData |
		         node := self newHeaderNode.
		         holder := self newHeaderNodeHolder.
		         node selectHolder: holder.
		         self headerNodeHolders add: holder.
		         selectedData := select data at: idx.
		         holder
			         node: node;
			         position: idx;
			         select: select;
			         data: selectedData.
		         self headerNodeBuilder value: node value: holder.
		         node ].
	self addAllDataNodes: nodes
]
