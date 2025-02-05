Class {
	#name : #ToInfiniteRecycler,
	#superclass : #BlInfiniteRecycler,
	#category : #'Toplo-Widget-List-Recycler'
}

{ #category : #initialization }
ToInfiniteRecycler >> newCustomRecycler [ 

	^ ToInfinitePositionBasedRecycler new
]
