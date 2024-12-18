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
