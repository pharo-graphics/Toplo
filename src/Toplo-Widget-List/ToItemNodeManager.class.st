Class {
	#name : #ToItemNodeManager,
	#superclass : #ToAbstractBarNodeManager,
	#category : #'Toplo-Widget-List-ItemBar'
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
		  size: 10 asPoint;
		  yourself
]

{ #category : #'instance creation' }
ToItemNodeManager >> newHolder [

	^ ToItemBarNodeHolder new
]

{ #category : #'instance creation' }
ToItemNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToItemNode new
]

{ #category : #initialization }
ToItemNodeManager >> unbuildNode: aNode [

	aNode item removeFromParent
]
