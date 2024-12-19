Class {
	#name : #ToTabNodeManager,
	#superclass : #ToAbstractBarNodeManager,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #initialization }
ToTabNodeManager >> buildNode: aNode [

	| holder |
	holder := aNode holder.
	aNode tab: holder dataItem
]

{ #category : #initialization }
ToTabNodeManager >> constraintNode: aNode [

	super constraintNode: aNode
]

{ #category : #initialization }
ToTabNodeManager >> defaultFakeDataItem [ 

	^ ToButton new
]

{ #category : #'instance creation' }
ToTabNodeManager >> newHolder [

	^ ToListNodeHolder new
]

{ #category : #'instance creation' }
ToTabNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToTabNode new
]

{ #category : #initialization }
ToTabNodeManager >> unbuildNode: aNode [

	aNode tab removeFromParent
]
