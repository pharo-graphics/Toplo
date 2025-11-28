Class {
	#name : #ToListInnerElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'previousDecorationSize'
	],
	#category : #'Toplo-Widget-List-InnerInfinite'
}

{ #category : #'infinite event handling' }
ToListInnerElementEventHandler >> boundsHasChangedDuringScrollingEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent: anEvent copy
]

{ #category : #'infinite event handling' }
ToListInnerElementEventHandler >> elementPositionChangedEvent: anEvent [

	anEvent currentTarget listElement updateAllSelections
]

{ #category : #'infinite event handling' }
ToListInnerElementEventHandler >> elementScrolledEvent: anEvent [

	anEvent delta = (0 @ 0) ifTrue: [ ^ self ].
	anEvent currentTarget listElement dispatchEvent: anEvent copy
]

{ #category : #'api - accessing' }
ToListInnerElementEventHandler >> eventsToHandle [

	^ {
		  ToInfiniteScrollFinishedEvent.
		  ToInfiniteDataSourceEmptinessChangedEvent.
		  BlInfiniteElementAttachedEvent.
		  BlInfiniteElementDetachedEvent.
		  BlElementScrolledEvent.
		  BlElementPositionChangedEvent.
		  BlBoundsHasChangedDuringScrollingEvent }
]

{ #category : #'infinite event handling' }
ToListInnerElementEventHandler >> infiniteDataSourceEmptinessChangedEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent: anEvent copy
]

{ #category : #'infinite event handling' }
ToListInnerElementEventHandler >> infiniteDecorationBoundsChangedEvent: anEvent [
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
ToListInnerElementEventHandler >> infiniteElementAttachedEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent:
		(ToListNodeAddedEvent new
			 node: anEvent element node;
			 yourself)
]

{ #category : #'infinite event handling' }
ToListInnerElementEventHandler >> infiniteElementDetachedEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent:
		(ToListNodeRemovedEvent new
			 node: anEvent element node;
			 yourself)
]

{ #category : #'infinite event handling' }
ToListInnerElementEventHandler >> infiniteScrollFinishedEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent: anEvent copy
]
