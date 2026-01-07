Class {
	#name : #ToInfiniteListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'previousDecorationSize'
	],
	#category : #'Toplo-Widget-List-InnerList-Infinite'
}

{ #category : #'infinite event handling' }
ToInfiniteListElementEventHandler >> boundsHasChangedDuringScrollingEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent: anEvent copy
]

{ #category : #'infinite event handling' }
ToInfiniteListElementEventHandler >> elementExtentChangedEvent: anEvent [

	anEvent currentTarget requestLayout
]

{ #category : #'infinite event handling' }
ToInfiniteListElementEventHandler >> elementPositionChangedEvent: anEvent [

	anEvent currentTarget listElement requestUpdateAllSelections
]

{ #category : #'infinite event handling' }
ToInfiniteListElementEventHandler >> elementScrolledEvent: anEvent [

	anEvent delta = (0 @ 0) ifTrue: [
			anEvent consume.
			^ self ].
	anEvent currentTarget listElement dispatchEvent: anEvent copy
]

{ #category : #'api - accessing' }
ToInfiniteListElementEventHandler >> eventsToHandle [

	^ {
		  ToListScrollFinishedEvent.
		  ToListDataSourceEmptinessChangedEvent.
		  BlInfiniteElementAttachedEvent.
		  BlInfiniteElementDetachedEvent.
		  BlElementScrolledEvent.
		  BlElementPositionChangedEvent.
		  BlBoundsHasChangedDuringScrollingEvent.
		  BlLayoutResizerChangedEvent.
		  BlElementExtentChangedEvent }
]

{ #category : #'infinite event handling' }
ToInfiniteListElementEventHandler >> infiniteDecorationBoundsChangedEvent: anEvent [
	" not used here but kept for the record "

	| s decoration insets |
	decoration := anEvent decoration.
	insets := decoration decorationInsets.
	(insets left > 0 or: [ insets right > 0 ]) ifTrue: [
		s := anEvent decoration computedBounds width.
		previousDecorationSize = s ifTrue: [ ^ self ].
		previousDecorationSize := s.
		"anEvent currentTarget listElement notifyPrimarySelectionDirty."
		^ self ].

	(insets top > 0 or: [ insets bottom > 0 ]) ifFalse: [ ^ self ].
	s := anEvent decoration computedBounds height.
	previousDecorationSize = s ifTrue: [ ^ self ].
	previousDecorationSize := s.
	"anEvent currentTarget listElement notifyPrimarySelectionDirty."
	^ self
]

{ #category : #'infinite event handling' }
ToInfiniteListElementEventHandler >> infiniteElementAttachedEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent:
		(ToListNodeAddedEvent new
			 node: anEvent element node;
			 yourself)
]

{ #category : #'infinite event handling' }
ToInfiniteListElementEventHandler >> infiniteElementDetachedEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent:
		(ToListNodeRemovedEvent new
			 node: anEvent element node;
			 yourself)
]

{ #category : #'infinite event handling' }
ToInfiniteListElementEventHandler >> layoutResizerChangedEvent: anEvent [

	anEvent currentTarget requestLayout
]

{ #category : #'infinite event handling' }
ToInfiniteListElementEventHandler >> listDataSourceEmptinessChangedEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent: anEvent copy
]

{ #category : #'infinite event handling' }
ToInfiniteListElementEventHandler >> listScrollFinishedEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent: anEvent copy
]
