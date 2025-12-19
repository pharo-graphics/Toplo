"
I have the responsibility to build the nodeContainers, the nodeHolders and the nodes.
For each data item I create a nodeContainer, its node and the holder that relates the data, the list, and the nodeContainer.  
"
Class {
	#name : #ToListNodeManager,
	#superclass : #Object,
	#instVars : [
		'checkableNode',
		'nodeContainerFactory',
		'nodeHolderFactory',
		'nodeFactory',
		'nodeContainerConfigurator',
		'nodeConfigurator'
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

{ #category : #'node configuration' }
ToListNodeManager >> configureNode: aNode [

	nodeConfigurator value: aNode
]

{ #category : #'node configuration' }
ToListNodeManager >> configureNodeContainer: aNodeContainer [

	nodeContainerConfigurator value: aNodeContainer 
]

{ #category : #initialization }
ToListNodeManager >> defaultNodeConfigurator [

	^ [ :node | ]
]

{ #category : #initialization }
ToListNodeManager >> defaultNodeContainerConfigurator [

	^ [ :nodeContainer | ]
]

{ #category : #initialization }
ToListNodeManager >> defaultNodeContainerFactory [

	^ [ ToNodeContainer new ]
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
	nodeContainerFactory := self defaultNodeContainerFactory.
	nodeFactory := self defaultNodeFactory.
	nodeHolderFactory := self defaultNodeHolderFactory.
	nodeContainerConfigurator := self defaultNodeContainerConfigurator.
	nodeConfigurator := self defaultNodeConfigurator 
]

{ #category : #'instance creation' }
ToListNodeManager >> newHolder [

	^ nodeHolderFactory value
]

{ #category : #'instance creation' }
ToListNodeManager >> newNodeContainer [ 

	^ nodeContainerFactory value
]

{ #category : #'instance creation' }
ToListNodeManager >> newNodeForHolder: aNodeHolder [

	^ nodeFactory cull: aNodeHolder
]

{ #category : #accessing }
ToListNodeManager >> nodeConfigurator [

	^ nodeConfigurator
]

{ #category : #accessing }
ToListNodeManager >> nodeConfigurator: aValuable [

	nodeConfigurator := aValuable
]

{ #category : #accessing }
ToListNodeManager >> nodeContainerConfigurator [

	^ nodeContainerConfigurator
]

{ #category : #accessing }
ToListNodeManager >> nodeContainerConfigurator: aValuable [

	nodeContainerConfigurator := aValuable
]

{ #category : #'instance creation' }
ToListNodeManager >> nodeContainerFactory: aValuable [
	" aValuable that takes no argument an return a new node container "

	nodeContainerFactory := aValuable
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
