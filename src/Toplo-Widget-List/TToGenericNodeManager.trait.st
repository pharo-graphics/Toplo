Trait {
	#name : #TToGenericNodeManager,
	#instVars : [
		'nodeFactory',
		'nodeBuilder',
		'nodeUnbuilder'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> buildNode: aNode [

	nodeBuilder
		cull: aNode
		cull: aNode holder dataItem
		cull: aNode holder
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> defaultNodeBuilder [

	^ [ :node :dataItem :holder |
	  node addChild: (ToLabel text: dataItem asString)  ]
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> defaultNodeFactory [

	^ [ :holder | ToListNode new ]
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> defaultNodeUnbuilder [

	^ [ :node :dataItem :holder |  ]
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> initializeAsGenericNodeManager [

	nodeBuilder := self defaultNodeBuilder.
	nodeUnbuilder := self defaultNodeUnbuilder.
	nodeFactory := self defaultNodeFactory
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> newHolder [

	^ ToNodeHolder new
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> newNodeForHolder: aNodeHolder [

	^ nodeFactory cull: aNodeHolder
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> nodeBuilder: aValuable [
	"aValuable takes 3 optional args: first, the node to build, second, the dataItem and third, the holder in the list element "

	nodeBuilder := aValuable
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> nodeFactory: aValuable [
	" aValuable that takes a node holder as unique argument and which running results in a new node "

	nodeFactory := aValuable
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> nodeUnbuilder: aValuable [

	"aValuable takes 3 args: first, the node to build, second, the dataItem and third the holder in the list element "
	nodeUnbuilder := aValuable
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> unbuildNode: aNode [

	nodeUnbuilder cull: aNode cull: aNode holder dataItem cull: aNode holder

]
