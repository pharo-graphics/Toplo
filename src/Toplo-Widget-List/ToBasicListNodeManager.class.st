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
		'nodeContainerConfigurator',
		'nodeConfigurator'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToBasicListNodeManager >> buildNode: aNode [ 

	aNode addChild: (ToLabel text: aNode holder dataItem asString)
]

{ #category : #initialization }
ToBasicListNodeManager >> buildNodeContainer: aNodeContainer [

	| listElement cbox |
	checkableNode ifFalse: [ ^ self ].
	listElement := aNodeContainer holder listElement.
	cbox := listElement newCheckboxInNodeContainer: aNodeContainer.
	cbox constraintsDo: [ :c | c linear vertical alignCenter ].
	aNodeContainer ensureStartContainer.
	aNodeContainer startContainer addChild: cbox
]

{ #category : #accessing }
ToBasicListNodeManager >> checkableNode [

	^ checkableNode
]

{ #category : #accessing }
ToBasicListNodeManager >> checkableNode: aBoolean [

	checkableNode := aBoolean 
]

{ #category : #'node configuration' }
ToBasicListNodeManager >> configureNode: aNode [

	nodeConfigurator value: aNode
]

{ #category : #'node configuration' }
ToBasicListNodeManager >> configureNodeContainer: aNodeContainer [

	nodeContainerConfigurator value: aNodeContainer 
]

{ #category : #initialization }
ToBasicListNodeManager >> defaultNodeConfigurator [

	^ [ :node | ]
]

{ #category : #initialization }
ToBasicListNodeManager >> defaultNodeContainerConfigurator [

	^ [ :nodeContainer | ]
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
	nodeHolderFactory := self defaultNodeHolderFactory.
	nodeContainerConfigurator := self defaultNodeContainerConfigurator.
	nodeConfigurator := self defaultNodeConfigurator 
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

{ #category : #accessing }
ToBasicListNodeManager >> nodeConfigurator [

	^ nodeConfigurator
]

{ #category : #accessing }
ToBasicListNodeManager >> nodeConfigurator: aValuable [

	nodeConfigurator := aValuable
]

{ #category : #accessing }
ToBasicListNodeManager >> nodeContainerConfigurator [

	^ nodeContainerConfigurator
]

{ #category : #accessing }
ToBasicListNodeManager >> nodeContainerConfigurator: aValuable [

	nodeContainerConfigurator := aValuable
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
