Trait {
	#name : #TToListNodeManager,
	#instVars : [
		'nodeContainerFactory',
		'nodeHolderFactory',
		'nodeFactory'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - list node manager' }
TToListNodeManager >> buildNode: aNode [

	
]

{ #category : #'t - list node manager' }
TToListNodeManager >> buildNodeContainer: aNodeContainer [
]

{ #category : #'t - list node manager' }
TToListNodeManager >> defaultNodeContainerFactory [

	^ [ ToNodeContainer new ]
]

{ #category : #'t - list node manager' }
TToListNodeManager >> defaultNodeFactory [

	^ [ :holder | ToBasicListNode new ]
]

{ #category : #'t - list node manager' }
TToListNodeManager >> defaultNodeHolderFactory [

	^ [ ToNodeHolder new ]
]

{ #category : #'t - list node manager' }
TToListNodeManager >> initializeAsListNodeManager [

	nodeContainerFactory := self defaultNodeContainerFactory.
	nodeFactory := self defaultNodeFactory.
	nodeHolderFactory := self defaultNodeHolderFactory
]

{ #category : #'t - list node manager' }
TToListNodeManager >> newHolder [

	^ nodeHolderFactory value
]

{ #category : #'t - list node manager' }
TToListNodeManager >> newNodeContainer [ 

	^ nodeContainerFactory value
]

{ #category : #'t - list node manager' }
TToListNodeManager >> newNodeForHolder: aNodeHolder [

	^ nodeFactory cull: aNodeHolder
]

{ #category : #'t - list node manager' }
TToListNodeManager >> nodeContainerFactory: aValuable [
	" aValuable that takes no argument an return a new node container "

	nodeContainerFactory := aValuable
]

{ #category : #'t - list node manager' }
TToListNodeManager >> nodeFactory: aValuable [
	" aValuable that takes a node holder as unique argument and which running results in a new node "

	nodeFactory := aValuable
]

{ #category : #'t - list node manager' }
TToListNodeManager >> nodeHolderFactory: aValuable [
	" aValuable that takes no argument an return a new holder "

	nodeHolderFactory := aValuable
]

{ #category : #'t - list node manager' }
TToListNodeManager >> unbuildNode: aNode [


]
