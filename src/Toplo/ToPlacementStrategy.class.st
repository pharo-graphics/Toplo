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

{ #category : #'opening-closing' }
ToPlacementStrategy >> popup: aWindow [
	self flag: 'Do a pass here. It seems that placement strategy is not needed '.

	self popup: aWindow event: nil 
]

{ #category : #'opening-closing' }
ToPlacementStrategy >> popup: aWindow event: anEvent [
	self flag: 'Do a pass here. It seems that placement strategy is not needed '.

	self subclassResponsibility 
]
