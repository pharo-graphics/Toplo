"
I have the responsibility to build the nodeContainers, the nodeHolders and the nodes.
For each data item I create a nodeContainer, its node and the holder that relates the data, the list, and the nodeContainer.  
"
Class {
	#name : #ToBasicListNodeManager,
	#superclass : #Object,
	#instVars : [
		'checkableNode',
		'nodeContainerFactory',
		'nodeHolderFactory',
		'nodeFactory',
		'isBuildingFakeNodeContainer'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToBasicListNodeManager >> buildNode: aNode [ 

	
]

{ #category : #initialization }
ToBasicListNodeManager >> buildNodeContainer: aNodeContainer [

	| listElement cbox |
	listElement := aNodeContainer holder listElement.
	checkableNode ifFalse: [ ^ self ].
	cbox := listElement newCheckboxInNodeContainer: aNodeContainer.
	cbox constraintsDo: [ :c | c linear vertical alignCenter ].
	aNodeContainer ensureStartContainer.
	aNodeContainer startContainer addChild: cbox.
	
]

{ #category : #accessing }
ToBasicListNodeManager >> checkableNode [

	^ checkableNode
]

{ #category : #accessing }
ToBasicListNodeManager >> checkableNode: aBoolean [

	checkableNode := aBoolean 
]

{ #category : #initialization }
ToBasicListNodeManager >> defaultNodeContainerFactory [

	^ [ ToNodeContainer new ]
]

{ #category : #initialization }
ToBasicListNodeManager >> defaultNodeFactory [

	^ [ :holder | ToBasicListNode new ]
]

{ #category : #initialization }
ToBasicListNodeManager >> defaultNodeHolderFactory [

	^ [ ToNodeHolder new ]
]

{ #category : #initialization }
ToBasicListNodeManager >> initialize [ 

	super initialize.
	checkableNode := false.
	nodeContainerFactory := self defaultNodeContainerFactory.
	nodeFactory := self defaultNodeFactory.
	nodeHolderFactory := self defaultNodeHolderFactory
]

{ #category : #'instance creation' }
ToBasicListNodeManager >> newHolder [

	^ nodeHolderFactory value
]

{ #category : #'instance creation' }
ToBasicListNodeManager >> newNodeContainer [ 

	^ nodeContainerFactory value
]

{ #category : #'instance creation' }
ToBasicListNodeManager >> newNodeForHolder: aNodeHolder [

	^ nodeFactory cull: aNodeHolder
]

{ #category : #'instance creation' }
ToBasicListNodeManager >> nodeContainerFactory: aValuable [
	" aValuable that takes no argument an return a new node container "

	nodeContainerFactory := aValuable
]

{ #category : #'instance creation' }
ToBasicListNodeManager >> nodeFactory: aValuable [
	" aValuable that takes a node holder as unique argument and which running results in a new node "

	nodeFactory := aValuable
]

{ #category : #'instance creation' }
ToBasicListNodeManager >> nodeHolderFactory: aValuable [
	" aValuable that takes no argument an return a new holder "

	nodeHolderFactory := aValuable
]

{ #category : #initialization }
ToBasicListNodeManager >> unbuildNode: aNode [


]
