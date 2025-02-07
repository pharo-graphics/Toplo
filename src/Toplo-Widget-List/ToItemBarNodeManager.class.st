Class {
	#name : #ToItemBarNodeManager,
	#superclass : #ToAbstractBarNodeManager,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToItemBarNodeManager >> buildNode: aNode [

	| holder |
	holder := aNode holder.
	aNode item: holder dataItem
]

{ #category : #initialization }
ToItemBarNodeManager >> defaultFakeDataItem [

	^ ToBarItemElement new
		  size: 10 asPoint;
		  yourself
]

{ #category : #'instance creation' }
ToItemBarNodeManager >> newHolder [

	^ ToItemNodeHolder new
]

{ #category : #'instance creation' }
ToItemBarNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToItemNode new
]

{ #category : #'as yet unclassified' }
ToItemBarNodeManager >> unbuildNode: aNode [

	aNode item removeFromParent
]
