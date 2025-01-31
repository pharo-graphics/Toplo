Class {
	#name : #ToItemListNodeManager,
	#superclass : #ToAbstractNodeManager,
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #initialization }
ToItemListNodeManager >> buildNode: aNode [

	| holder |
	holder := aNode holder.
	aNode item: holder dataItem
]

{ #category : #initialization }
ToItemListNodeManager >> constraintNode: aNode [

	| list |
	list := aNode holder listElement.
	list isVertical
		ifTrue: [
			list isHMatchParent
				ifTrue: [ aNode hMatchParent ]
				ifFalse: [ aNode hFitContent ].
			aNode vFitContent ]
		ifFalse: [
			list isVMatchParent
				ifTrue: [ aNode vMatchParent ]
				ifFalse: [ aNode vFitContent ].
			aNode hFitContent ]
]

{ #category : #'instance creation' }
ToItemListNodeManager >> newHolder [

	^ ToItemBarNodeHolder new
]

{ #category : #'instance creation' }
ToItemListNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToItemNode new
]

{ #category : #initialization }
ToItemListNodeManager >> unbuildNode: aNode [

	| holder |
	holder := aNode holder.
	aNode item: nil.
	aNode removeChildren.
]
