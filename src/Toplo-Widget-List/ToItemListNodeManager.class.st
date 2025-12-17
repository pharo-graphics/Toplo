Class {
	#name : #ToItemListNodeManager,
	#superclass : #ToListNodeManager,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToItemListNodeManager >> buildNode: aNode [

	| holder |
	holder := aNode holder.
	aNode item: holder dataItem
]

{ #category : #initialization }
ToItemListNodeManager >> defaultNodeFactory [ 

	^ [ :holder | ToListItemNode new ]
]

{ #category : #initialization }
ToItemListNodeManager >> defaultNodeHolderFactory [ 

	^ [ ToItemNodeHolder new ]
]

{ #category : #initialization }
ToItemListNodeManager >> unbuildNode: aNode [

	aNode item removeFromParent
]
