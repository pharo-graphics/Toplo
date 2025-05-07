Class {
	#name : #ToItemBarNodeManager,
	#superclass : #ToAbstractBarNodeManager,
	#category : #'Toplo-Widget-List-ItemBar'
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
]

{ #category : #'instance creation' }
ToItemBarNodeManager >> newHolder [

	^ ToItemNodeHolder new
]

{ #category : #'instance creation' }
ToItemBarNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToBarItemNode new
]

{ #category : #initialization }
ToItemBarNodeManager >> unbuildNode: aNode [

	aNode item removeFromParent
]
