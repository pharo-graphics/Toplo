Class {
	#name : #ToItemNodeManager,
	#superclass : #ToAbstractBarNodeManager,
	#category : #'Toplo-Widget-Menu-Item-List'
}

{ #category : #initialization }
ToItemNodeManager >> buildNode: aNode [

	| holder |
	holder := aNode holder.
	aNode item: holder dataItem
]

{ #category : #initialization }
ToItemNodeManager >> constraintFakeNode: aNode [

	| bar |
	bar := aNode holder listElement.
	aNode constraintsDo: [ :c |
		c horizontal exact: 0.
		c vertical exact: 0.
		c flow vertical alignCenter.
		c linear vertical alignCenter ]
]

{ #category : #initialization }
ToItemNodeManager >> constraintNode: aNode [

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
ToItemNodeManager >> defaultFakeDataItem [ 

	^ ToElement new
]

{ #category : #'instance creation' }
ToItemNodeManager >> newHolder [

	^ ToListNodeHolder new
]

{ #category : #'instance creation' }
ToItemNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToItemNode new
]

{ #category : #initialization }
ToItemNodeManager >> unbuildNode: aNode [

	aNode item removeFromParent
]
