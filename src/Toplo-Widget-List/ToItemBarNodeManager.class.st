Class {
	#name : #ToItemBarNodeManager,
	#superclass : #ToAbstractBarNodeManager,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToItemBarNodeManager >> applyNodeConstraintsOn: aNode [

	| bar |
	bar := aNode holder listElement.
	bar isWrapping
		ifFalse: [
			bar isVertical
				ifTrue: [
					bar isHMatchParent
						ifTrue: [ aNode hMatchParent ]
						ifFalse: [ aNode hFitContent ].
					bar autoDistribute
						ifTrue: [ aNode vMatchParent ]
						ifFalse: [ aNode vFitContent ] ]
				ifFalse: [
					bar isVMatchParent
						ifTrue: [ aNode vMatchParent ]
						ifFalse: [ aNode vFitContent ].
					bar autoDistribute
						ifTrue: [ aNode hMatchParent ]
						ifFalse: [ aNode hFitContent ] ] ]
		ifTrue: [ aNode fitContent ].

	bar isWrapping ifTrue: [ ^ self ].
	bar isScrolling ifTrue: [ ^ self ].
	bar autoDistribute ifFalse: [ ^ self ].

	bar isHorizontal
		ifTrue: [ aNode hMatchParent ]
		ifFalse: [ aNode vMatchParent ]
]

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

{ #category : #initialization }
ToItemBarNodeManager >> unbuildNode: aNode [

	aNode item removeFromParent
]
