Class {
	#name : #ToInfiniteSimpleNodePoolRecycler,
	#superclass : #BlInfiniteCustomRecycler,
	#instVars : [
		'pool'
	],
	#category : #'Toplo-Widget-List-Recycler'
}

{ #category : #'element fetching' }
ToInfiniteSimpleNodePoolRecycler >> elementFor: aPosition in: anInfiniteElement [

	| e |
	e := pool acquire.
	e ifNil: [ ^ nil ].
	^ e holder
]

{ #category : #initialization }
ToInfiniteSimpleNodePoolRecycler >> initialize [

	super initialize.
	pool := BlArrayObjectPool new.
	pool setPool: (Array new: self poolSize)
]

{ #category : #initialization }
ToInfiniteSimpleNodePoolRecycler >> poolSize [

	^ 10
]

{ #category : #recycling }
ToInfiniteSimpleNodePoolRecycler >> recycleElement: anElement in: anInfiniteElement [

	" just store the node for futur reuse "
	pool release: anElement
]
