Class {
	#name : #ToMenuNodeManager,
	#superclass : #ToAbstractBarNodeManager,
	#category : #'Toplo-Widget-Menu-Item-List'
}

{ #category : #initialization }
ToMenuNodeManager >> buildNode: aNode [

	| holder |
	holder := aNode holder.
	aNode item: holder dataItem
]

{ #category : #initialization }
ToMenuNodeManager >> constraintFakeNode: aNode [

	| bar |
	bar := aNode holder listElement.
	aNode constraintsDo: [ :c |
		c horizontal exact: 0.
		c vertical exact: 0.
		c flow vertical alignCenter.
		c linear vertical alignCenter ]
]

{ #category : #initialization }
ToMenuNodeManager >> constraintNode: aNode [

	super constraintNode: aNode.
	aNode hFitContent.
	aNode vFitContent.
	aNode constraintsDo: [ :c |
		c linear vertical alignCenter.
		c flow vertical alignCenter.
		c linear horizontal alignCenter.
		c flow horizontal alignCenter ].
	aNode holder dataItem constraintMenuNode: aNode.

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
