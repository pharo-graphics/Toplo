Class {
	#name : #ToMenuNodeManager,
	#superclass : #ToAbstractBarNodeManager,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #initialization }
ToMenuNodeManager >> buildNode: aNode [

	| holder |
	holder := aNode holder.
	aNode item: holder dataItem
]

{ #category : #initialization }
ToMenuNodeManager >> constraintNode: aNode [

	super constraintNode: aNode.
	aNode hFitContent
]

{ #category : #initialization }
ToMenuNodeManager >> defaultFakeDataItem [ 

	^ ToMenuItem new
]

{ #category : #'instance creation' }
ToMenuNodeManager >> newHolder [

	^ ToListNodeHolder new
]

{ #category : #'instance creation' }
ToMenuNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToMenuNode new
]

{ #category : #initialization }
ToMenuNodeManager >> unbuildNode: aNode [

	aNode item removeFromParent
]
