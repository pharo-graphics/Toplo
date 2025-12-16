Class {
	#name : #ToItemFiniteListNodeManager,
	#superclass : #ToFiniteListNodeManager,
	#category : #'Toplo-Widget-List-ItemFiniteList'
}

{ #category : #initialization }
ToItemFiniteListNodeManager >> buildNode: aNode [

	| holder |
	holder := aNode holder.
	aNode item: holder dataItem
]

{ #category : #initialization }
ToItemFiniteListNodeManager >> defaultNodeFactory [

	^ [ :holder | ToFiniteListItemNode new ]
]

{ #category : #initialization }
ToItemFiniteListNodeManager >> defaultNodeHolderFactory [ 

	^ [ ToItemNodeHolder new ]
]

{ #category : #initialization }
ToItemFiniteListNodeManager >> unbuildNode: aNode [

	aNode item removeFromParent
]
