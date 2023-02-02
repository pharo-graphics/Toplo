Class {
	#name : #ToPlacementStrategy,
	#superclass : #Object,
	#category : #'Toplo-Widget-Window'
}

{ #category : #'opening-closing' }
ToPlacementStrategy >> check: aWindow beforePopupIn: aWidget [

	" my bounds are up-to-date, I can be visible "
	| anim |
	aWindow visibility: BlVisibility visible.
	aWindow animate ifFalse: [ ^ self ].
	anim := aWindow popupAnimationFactory value.
	anim ifNil: [ ^ self ].
	aWindow addAnimation: anim
]
