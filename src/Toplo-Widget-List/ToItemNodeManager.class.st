Class {
	#name : #ToItemNodeManager,
	#superclass : #ToAbstractBarNodeManager,
	#category : #'Toplo-Widget-List-ItemList'
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
	aNode visibility: BlVisibility hidden.
	aNode constraintsDo: [ :c |
		c horizontal exact: 0.
		c vertical exact: 0 ]
]

{ #category : #initialization }
ToItemNodeManager >> constraintNode: aNode [

	| bar |
	super constraintNode: aNode.
	bar := aNode holder listElement.
	bar nodeScrolling ifTrue: [ ^ self ].
 	bar nodeAutoDistribution ifTrue: [
		aNode item constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ] ]
]

{ #category : #initialization }
ToItemNodeManager >> defaultFakeDataItem [ 

	^ ToItemElement new
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
