Class {
	#name : #ToItemListNodeManager,
	#superclass : #ToBasicListNodeManager,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToItemListNodeManager >> buildNode: aNode [

	| holder |
	holder := aNode holder.
	aNode item: holder dataItem
]

{ #category : #initialization }
ToItemListNodeManager >> defaultNodeContainerFactory [

	^ [ ToItemNodeContainer new ]
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
