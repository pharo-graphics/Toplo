Class {
	#name : #ToInfiniteDataItemBasedRecycler,
	#superclass : #BlInfiniteCustomRecycler,
	#instVars : [
		'pool'
	],
	#category : #'Toplo-Widget-List-Recycler'
}

{ #category : #'element fetching' }
ToInfiniteDataItemBasedRecycler >> elementFor: aDataItem in: anInfiniteElement [

	| e |
	e := pool at: aDataItem ifAbsent: [].
	e ifNil: [ ^ nil ].
	pool removeKey: aDataItem.
	^ e holder
]

{ #category : #initialization }
ToInfiniteDataItemBasedRecycler >> initialize [

	super initialize.
	pool := IdentityDictionary new.
]

{ #category : #initialization }
ToInfiniteDataItemBasedRecycler >> poolSize [

	^ 100
]

{ #category : #recycling }
ToInfiniteDataItemBasedRecycler >> recycleElement: anElement in: anInfiniteElement [

	anElement holder recyclingRequested ifFalse: [ ^ self ].
	" just store the node for futur reuse "
	pool at: anElement holder dataItem put: anElement
]

{ #category : #accessing }
ToInfiniteDataItemBasedRecycler >> removeNodeAt: aDataItem in: anInfiniteElement [

	^ pool removeKey: aDataItem ifAbsent: []
]
