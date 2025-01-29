Trait {
	#name : #TToGenericNodeManager,
	#instVars : [
		'nodeFactory',
		'nodeBuilder',
		'nodeUnbuilder',
		'holderClass'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> buildNode: aNode [ 


	nodeBuilder cull: aNode cull: aNode holder dataItem cull: aNode holder
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> holderClass: aNodeHolderClass [

	holderClass := aNodeHolderClass
]

{ #category : #'t - generic node manager' }
TToGenericNodeManager >> newHolder [

	^ holderClass new
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

	nodeUnbuilder cull: aNode cull: aNode holder dataItem cull: aNode holder.
	aNode removeChildren


]
