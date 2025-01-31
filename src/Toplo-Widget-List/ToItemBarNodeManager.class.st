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

{ #category : #'as yet unclassified' }
ToItemBarNodeManager >> defaultFakeDataItem [

	^ ToItemElement new
		  size: 10 asPoint;
		  yourself
]

{ #category : #'instance creation' }
ToItemBarNodeManager >> newHolder [

	^ ToItemBarNodeHolder new
]

{ #category : #'instance creation' }
ToItemBarNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToItemNode new
]

{ #category : #initialization }
ToItemBarNodeManager >> unbuildNode: aNode [

	aNode item removeFromParent
]
