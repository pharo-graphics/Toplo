Trait {
	#name : #TToGenericNodeManager,
	#instVars : [
		'nodeBuilder',
		'nodeUnbuilder',
		'nodeContainerBuilder'
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
TToGenericNodeManager >> buildNodeContainer: aNodeContainer [


	super buildNodeContainer: aNodeContainer.
	nodeContainerBuilder
		cull: aNodeContainer
		cull: aNodeContainer holder dataItem
		cull: aNodeContainer holder
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> defaultNodeBuilder [

	^ [ :node :dataItem :holder |
	  node addChild: (ToLabel text: dataItem asString)  ]
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> defaultNodeContainerBuilder [

	^ [ :nodeContainer :dataItem :holder |  ]
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> defaultNodeUnbuilder [

	^ [ :node :dataItem :holder |  ]
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> initializeAsGenericNodeManager [

	nodeContainerBuilder := self defaultNodeContainerBuilder.
	nodeBuilder := self defaultNodeBuilder.
	nodeUnbuilder := self defaultNodeUnbuilder.

]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> nodeBuilder [
	"aValuable takes 3 optional args: first, the node to build, second, the dataItem and third, the holder in the list element "

	^ nodeBuilder
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> nodeBuilder: aValuable [
	"aValuable takes 3 optional args: first, the node to build, second, the dataItem and third, the holder in the list element "

	nodeBuilder := aValuable
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> nodeContainerBuilder [
	"aValuable takes 3 optional args: first, the nodeContainer to build, second, the dataItem and third, the holder in the list element "

	^ nodeContainerBuilder
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> nodeContainerBuilder: aValuable [
	"aValuable takes 3 optional args: first, the nodeContainer to build, second, the dataItem and third, the holder in the list element "

	nodeContainerBuilder := aValuable
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
