"
I have the responsibility to build the nodeContainers, the nodeHolders and the nodes.
For each data item I create a nodeContainer, its node and the holder that relates the data, the list, and the nodeContainer.  
"
Class {
	#name : #ToAbstractNodeManager,
	#superclass : #Object,
	#instVars : [
		'checkableNode',
		'nodeHolderFactory',
		'nodeFactory'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToAbstractNodeManager >> buildNode: aNode [ 

]

{ #category : #initialization }
ToAbstractNodeManager >> buildNodeContainer: aNodeContainer [

	| listElement cbox |
	checkableNode ifFalse: [ ^ self ].
	listElement := aNodeContainer holder listElement.
	cbox := listElement newCheckboxInNodeContainer: aNodeContainer.
	cbox constraintsDo: [ :c | c linear vertical alignCenter ].
	aNodeContainer ensureStartContainer.
	aNodeContainer startContainer addChild: cbox
]

{ #category : #accessing }
ToAbstractNodeManager >> checkableNode [

	^ checkableNode
]

{ #category : #accessing }
ToAbstractNodeManager >> checkableNode: aBoolean [

	checkableNode := aBoolean 
]

{ #category : #initialization }
ToAbstractNodeManager >> defaultNodeFactory [

	^ [ :holder | ToListNode new ]
]

{ #category : #initialization }
ToAbstractNodeManager >> defaultNodeHolderFactory [

	^ [ ToNodeHolder new ]
]

{ #category : #initialization }
ToAbstractNodeManager >> initialize [ 

	super initialize.
	checkableNode := false.
	nodeFactory := self defaultNodeFactory.
	nodeHolderFactory := self defaultNodeHolderFactory
]

{ #category : #'instance creation' }
ToAbstractNodeManager >> newHolder [

	^ nodeHolderFactory value
]

{ #category : #'instance creation' }
ToAbstractNodeManager >> newNodeContainer [ 

	^ ToNodeContainer new
]

{ #category : #'instance creation' }
ToAbstractNodeManager >> newNodeForHolder: aNodeHolder [

	^ nodeFactory cull: aNodeHolder
]

{ #category : #'instance creation' }
ToAbstractNodeManager >> nodeFactory: aValuable [
	" aValuable that takes a node holder as unique argument and which running results in a new node "

	nodeFactory := aValuable
]

{ #category : #'instance creation' }
ToAbstractNodeManager >> nodeHolderFactory: aValuable [
	" aValuable that takes no argument an return a new holder "

	nodeHolderFactory := aValuable
]

{ #category : #initialization }
ToAbstractNodeManager >> unbuildNode: aNode [


]
