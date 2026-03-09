Class {
	#name : #ToInfiniteRecycler,
	#superclass : #BlInfiniteRecycler,
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToInfiniteRecycler >> customRecycler [

	^ customRecycler
]

{ #category : #initialization }
ToInfiniteRecycler >> newCustomRecycler [ 

	^ ToInfinitePositionBasedRecycler new
]
