Class {
	#name : #ToInfinitePositionBasedRecycler,
	#superclass : #BlInfiniteCustomRecycler,
	#instVars : [
		'pool'
	],
	#category : #'Toplo-Widget-List-Recycler'
}

{ #category : #'element fetching' }
ToInfinitePositionBasedRecycler >> elementFor: aPosition in: anInfiniteElement [

	| e |
	e := pool at: aPosition ifAbsent: [].
	e ifNil: [ ^ nil ].
	pool removeKey: aPosition.
	^ e holder
]

{ #category : #initialization }
ToInfinitePositionBasedRecycler >> initialize [

	super initialize.
	pool := IdentityDictionary new.
]

{ #category : #'element fetching' }
ToInfinitePositionBasedRecycler >> nodeAt: aPosition in: anInfiniteElement [

	^ pool at: aPosition ifAbsent: []
]

{ #category : #initialization }
ToInfinitePositionBasedRecycler >> poolSize [

	^ 10
]

{ #category : #recycling }
ToInfinitePositionBasedRecycler >> recycleElement: anElement in: anInfiniteElement [

	anElement holder recyclingRequested ifFalse: [ ^ self ].
	" just store the node for futur reuse "
	pool at: anElement holder position put: anElement
]

{ #category : #'element fetching' }
ToInfinitePositionBasedRecycler >> removeNodeAt: aPosition in: anInfiniteElement [

	^ pool removeKey: aPosition ifAbsent: []
]
