"
I have the responsibility to build the nodeContainers, the nodeHolders and the nodes.
For each data item I create a nodeContainer, its node and the holder that relates the data, the list, and the nodeContainer.  
"
Class {
	#name : #ToListNodeManager,
	#superclass : #Object,
	#instVars : [
		'checkableNode',
		'nodeHolderFactory',
		'nodeFactory'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToListNodeManager >> buildNode: aNode [ 

	aNode addChild: (ToLabel text: aNode holder dataItem asString)
]

{ #category : #initialization }
ToListNodeManager >> buildNodeContainer: aNodeContainer [

	| listElement cbox |
	checkableNode ifFalse: [ ^ self ].
	listElement := aNodeContainer holder listElement.
	cbox := listElement newCheckboxInNodeContainer: aNodeContainer.
	cbox constraintsDo: [ :c | c linear vertical alignCenter ].
	aNodeContainer ensureStartContainer.
	aNodeContainer startContainer addChild: cbox
]

{ #category : #accessing }
ToListNodeManager >> checkableNode [

	^ checkableNode
]

{ #category : #accessing }
ToListNodeManager >> checkableNode: aBoolean [

	checkableNode := aBoolean 
]

{ #category : #initialization }
ToListNodeManager >> defaultNodeFactory [

	^ [ :holder | ToListNode new ]
]

{ #category : #initialization }
ToListNodeManager >> defaultNodeHolderFactory [

	^ [ ToNodeHolder new ]
]

{ #category : #initialization }
ToListNodeManager >> initialize [ 

	super initialize.
	checkableNode := false.
	nodeFactory := self defaultNodeFactory.
	nodeHolderFactory := self defaultNodeHolderFactory
]

{ #category : #'instance creation' }
ToListNodeManager >> newHolder [

	^ nodeHolderFactory value
]

{ #category : #'instance creation' }
ToListNodeManager >> newNodeContainer [ 

	^ ToNodeContainer new
]

{ #category : #'instance creation' }
ToListNodeManager >> newNodeForHolder: aNodeHolder [

	^ nodeFactory cull: aNodeHolder
]

{ #category : #'instance creation' }
ToListNodeManager >> nodeFactory: aValuable [
	" aValuable that takes a node holder as unique argument and which running results in a new node "

	nodeFactory := aValuable
]

{ #category : #'instance creation' }
ToListNodeManager >> nodeHolderFactory: aValuable [
	" aValuable that takes no argument an return a new holder "

	nodeHolderFactory := aValuable
]

{ #category : #initialization }
ToListNodeManager >> unbuildNode: aNode [


]
