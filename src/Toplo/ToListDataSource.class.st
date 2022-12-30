Class {
	#name : #ToListDataSource,
	#superclass : #ToInfiniteDataSource,
	#category : #'Toplo-Core-Infinite'
}

{ #category : #accessing }
ToListDataSource >> itemTypeAt: aPosition [
	"All my items are homogene, it is enough to use 0"

	^ ToListItemType new
]
