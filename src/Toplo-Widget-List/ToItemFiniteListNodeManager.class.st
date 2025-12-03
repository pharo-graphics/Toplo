Class {
	#name : #ToItemFiniteListNodeManager,
	#superclass : #ToAbstractBarNodeManager,
	#category : #'Toplo-Widget-List-ItemFiniteList'
}

{ #category : #initialization }
ToItemFiniteListNodeManager >> buildNode: aNode [

	| holder |
	holder := aNode holder.
	aNode item: holder dataItem
]

{ #category : #initialization }
ToItemFiniteListNodeManager >> defaultFakeDataItem [

	^ ToFiniteListItem new
]

{ #category : #'instance creation' }
ToItemFiniteListNodeManager >> newHolder [

	^ ToItemNodeHolder new
]

{ #category : #'instance creation' }
ToItemFiniteListNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToFiniteListItemNode new
]

{ #category : #initialization }
ToItemFiniteListNodeManager >> unbuildNode: aNode [

	aNode item removeFromParent
]
