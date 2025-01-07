Class {
	#name : #ToMenuWindowPickOutsideEventFilter,
	#superclass : #ToPopupPickOutsideEventFilter,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #private }
ToMenuWindowPickOutsideEventFilter >> isPickedOutsideEvent: anEvent [
	" return true if the event is considered as a pick outside event "

	| target |
	target := anEvent target.
	(target hasAnyInParentChainSatisfying: [ :e | e isKindOf: ToMenuItem ])
		ifTrue: [ ^ false ].
	^ super isPickedOutsideEvent: anEvent
]
