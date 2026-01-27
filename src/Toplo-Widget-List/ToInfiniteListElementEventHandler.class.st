Class {
	#name : #ToInfiniteListElementEventHandler,
	#superclass : #ToListInnerElementEventHandler,
	#category : #'Toplo-Widget-List-InnerList-Infinite'
}

{ #category : #'element handlers' }
ToInfiniteListElementEventHandler >> boundsHasChangedDuringScrollingEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget listElement.
	listElement forceUpdateAllSelectionsNow.
	listElement requestMouseMoveReplay
]

{ #category : #'element handlers' }
ToInfiniteListElementEventHandler >> elementScrolledEvent: anEvent [

	| listElement |
	anEvent delta = (0 @ 0) ifTrue: [
			anEvent consume.
			^ self ].
	listElement := anEvent currentTarget listElement.
	listElement forceUpdateAllSelectionsNow.
	listElement requestMouseMoveReplay
]

{ #category : #'api - accessing' }
ToInfiniteListElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , { BlBoundsHasChangedDuringScrollingEvent. BlElementScrolledEvent }
]

{ #category : #'infinite event handling' }
ToInfiniteListElementEventHandler >> infiniteDecorationBoundsChangedEvent: anEvent [
	" not used here but kept for the record "

	| s decoration insets |
	decoration := anEvent decoration.
	insets := decoration decorationInsets.
	(insets left > 0 or: [ insets right > 0 ]) ifTrue: [
		s := anEvent decoration computedBounds width.
		"previousDecorationSize = s ifTrue: [ ^ self ].
		previousDecorationSize := s."
		"anEvent currentTarget listElement notifyPrimarySelectionDirty."
		^ self ].

	(insets top > 0 or: [ insets bottom > 0 ]) ifFalse: [ ^ self ].
	s := anEvent decoration computedBounds height.
	"previousDecorationSize = s ifTrue: [ ^ self ].
	previousDecorationSize := s."
	"anEvent currentTarget listElement notifyPrimarySelectionDirty."
	^ self
]
