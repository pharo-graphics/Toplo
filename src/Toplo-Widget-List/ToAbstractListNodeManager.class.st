Class {
	#name : #ToAbstractListNodeManager,
	#superclass : #Object,
	#instVars : [
		'nodeHolderClass',
		'nodeFactory',
		'nodeBuilder'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'instance creation' }
ToAbstractListNodeManager >> buildNode: aNode inHolder: aNodeHolder [

	nodeBuilder cull: aNode cull: aNodeHolder cull: aNodeHolder dataItem.
]

{ #category : #initialization }
ToAbstractListNodeManager >> constraintNode: aNode [

	aNode constraintsDo: [ :c |
		  c horizontal matchParent.
		  c vertical fitContent ] 
]

{ #category : #initialization }
ToAbstractListNodeManager >> defaultNodeBuilder [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToAbstractListNodeManager >> defaultNodeFactory [

	^ [ :holder | ToListNode new ]
]

{ #category : #initialization }
ToAbstractListNodeManager >> defaultNodeHolderClass [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToAbstractListNodeManager >> initialize [

	super initialize.
	nodeHolderClass := self defaultNodeHolderClass.
	nodeBuilder := self defaultNodeBuilder.
	nodeFactory := self defaultNodeFactory
]

{ #category : #'instance creation' }
ToAbstractListNodeManager >> newNodeForHolder: aNodeHolder [

	| node infiniteConstraints |
	node := nodeFactory cull: aNodeHolder.
	infiniteConstraints := node constraints infinite.
	infiniteConstraints holder: aNodeHolder.
	^ node
]

{ #category : #'instance creation' }
ToAbstractListNodeManager >> newNodeHolder [

	^ nodeHolderClass new
]

{ #category : #accessing }
ToAbstractListNodeManager >> nodeBuilder: aValuable [

	"aValuable takes 2 args: first, the node to build and second, its holder in the list element "
	nodeBuilder := aValuable
]

{ #category : #accessing }
ToAbstractListNodeManager >> nodeFactory: aValuable [
	" aValuable that takes a node holder as unique argument and which running results in a new node "

	nodeFactory := aValuable
]

{ #category : #accessing }
ToAbstractListNodeManager >> nodeHolderClass: aNodeHolderClass [

	nodeHolderClass := aNodeHolderClass
]

{ #category : #initialization }
ToAbstractListNodeManager >> unbindNode: aNode [


]
