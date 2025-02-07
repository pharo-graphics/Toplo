Class {
	#name : #ToInfiniteRecycler,
	#superclass : #BlInfiniteRecycler,
	#category : #'Toplo-Widget-List-Recycler'
}

{ #category : #accessing }
ToInfiniteRecycler >> customRecycler [

	^ customRecycler
]

{ #category : #initialization }
ToInfiniteRecycler >> newCustomRecycler [ 

	^ ToInfinitePositionBasedRecycler new
]
