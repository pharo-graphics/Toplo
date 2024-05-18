Class {
	#name : #ToListNodeManager,
	#superclass : #Object,
	#instVars : [
		'nodeHolderClass',
		'nodeFactory',
		'nodeBuilder'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'instance creation' }
ToListNodeManager >> builderNode: aNode inHolder: aNodeHolder [

	nodeBuilder cull: aNode cull: aNodeHolder cull: aNodeHolder dataItem.
]

{ #category : #initialization }
ToListNodeManager >> defaultNodeBuilder [

	^ [ :node :holder :dataItem |
	  node addChild: (ToLabel text: dataItem asString) hMatchParent ]
]

{ #category : #initialization }
ToListNodeManager >> defaultNodeFactory [

	^ [ :holder | ToNode new ]
]

{ #category : #initialization }
ToListNodeManager >> defaultNodeHolderClass [

	^ ToNodeHolder
]

{ #category : #initialization }
ToListNodeManager >> initialize [ 

	super initialize.
	nodeHolderClass := self defaultNodeHolderClass.
	nodeBuilder := self defaultNodeBuilder.
	nodeFactory := self defaultNodeFactory
]

{ #category : #'instance creation' }
ToListNodeManager >> newNodeHolder [

	^ nodeHolderClass new
]

{ #category : #'instance creation' }
ToListNodeManager >> newNodeInHolder: aNodeHolder [

	| node infiniteConstraints |
	node := nodeFactory cull: aNodeHolder.
	infiniteConstraints := node constraints infinite.
	infiniteConstraints holder: aNodeHolder.
	^ node
]

{ #category : #accessing }
ToListNodeManager >> nodeBuilder: aValuable [

	"aValuable takes 2 args: first, the node to build and second, its holder in the list element "
	nodeBuilder := aValuable
]

{ #category : #accessing }
ToListNodeManager >> nodeFactory: aValuable [
	" aValuable that takes a node holder as unique argument and which running results in a new node "

	nodeFactory := aValuable
]

{ #category : #accessing }
ToListNodeManager >> nodeHolderClass: aNodeHolderClass [

	nodeHolderClass := aNodeHolderClass
]
