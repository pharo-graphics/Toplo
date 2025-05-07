Class {
	#name : #ToItemListNodeManager,
	#superclass : #ToAbstractNodeManager,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToItemListNodeManager >> buildNode: aNode [

	| holder |
	holder := aNode holder.
	aNode item: holder dataItem
]

{ #category : #'instance creation' }
ToItemListNodeManager >> newHolder [

	^ ToItemNodeHolder new
]

{ #category : #'instance creation' }
ToItemListNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToBarItemNode new
]
