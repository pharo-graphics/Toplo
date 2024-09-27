Class {
	#name : #ToAbstractListNodeManager,
	#superclass : #Object,
	#instVars : [
		'nodeFactory',
		'nodeBuilder',
		'nodeUnbuilder',
		'holderClass'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'instance creation' }
ToAbstractListNodeManager >> buildNode: aNode inHolder: aNodeHolder [

	aNodeHolder node: aNode.
	nodeBuilder cull: aNode cull: aNodeHolder dataItem cull: aNodeHolder
]

{ #category : #initialization }
ToAbstractListNodeManager >> constraintNode: aNode [

	aNode constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ]
]

{ #category : #initialization }
ToAbstractListNodeManager >> defaultHolderClass [

	^ self subclassResponsibility 
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
ToAbstractListNodeManager >> defaultNodeUnbuilder [

	^ [ :node :dataItem :holder | ]
]

{ #category : #accessing }
ToAbstractListNodeManager >> holderClass: aNodeHolderClass [

	holderClass := aNodeHolderClass
]

{ #category : #initialization }
ToAbstractListNodeManager >> initialize [

	super initialize.
	holderClass := self defaultHolderClass.
	nodeBuilder := self defaultNodeBuilder.
	nodeUnbuilder := self defaultNodeUnbuilder.
	nodeFactory := self defaultNodeFactory
]

{ #category : #'instance creation' }
ToAbstractListNodeManager >> newHolder [

	^ holderClass new
]

{ #category : #'instance creation' }
ToAbstractListNodeManager >> newNodeForHolder: aNodeHolder [

	| node infiniteConstraints |
	node := nodeFactory cull: aNodeHolder.
	infiniteConstraints := node constraints infinite.
	infiniteConstraints holder: aNodeHolder.
	^ node
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
ToAbstractListNodeManager >> nodeUnbuilder: aValuable [

	"aValuable takes 2 args: first, the node to build and second, its holder in the list element "
	nodeUnbuilder := aValuable
]

{ #category : #initialization }
ToAbstractListNodeManager >> unbuildNode: aNode [

	nodeUnbuilder cull: aNode cull: aNode holder dataItem cull: aNode holder.


]
