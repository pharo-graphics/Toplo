Class {
	#name : #ToListInnerContainerEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'previousDecorationSize'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'infinite event handling' }
ToListInnerContainerEventHandler >> boundsHasChangedDuringScrollingEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent: anEvent
]

{ #category : #'infinite event handling' }
ToListInnerContainerEventHandler >> elementScrolledEvent: anEvent [

	anEvent delta = (0 @ 0) ifTrue: [ ^ self ].
	anEvent currentTarget listElement dispatchEvent: anEvent 
]

{ #category : #'api - accessing' }
ToListInnerContainerEventHandler >> eventsToHandle [

	^ {
		  ToInfiniteScrollFinishedEvent.
		  ToInfiniteDataSourceEmptinessChangedEvent.
		  BlInfiniteElementAttachedEvent.
		  BlInfiniteElementDetachedEvent.
		  BlElementScrolledEvent.
		  BlBoundsHasChangedDuringScrollingEvent }
]

{ #category : #'infinite event handling' }
ToListInnerContainerEventHandler >> infiniteDataSourceEmptinessChangedEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent: anEvent 
]

{ #category : #'infinite event handling' }
ToListInnerContainerEventHandler >> infiniteDecorationBoundsChangedEvent: anEvent [
	" not used here but kept for the record "

	| s decoration insets |
	decoration := anEvent decoration.
	insets := decoration decorationInsets.
	(insets left > 0 or: [ insets right > 0 ]) ifTrue: [
		s := anEvent decoration computedBounds width.
		previousDecorationSize = s ifTrue: [ ^ self ].
		previousDecorationSize := s.
		anEvent currentTarget listElement notifyPrimarySelectionDirty.
		^ self ].

	(insets top > 0 or: [ insets bottom > 0 ]) ifFalse: [ ^ self ].
	s := anEvent decoration computedBounds height.
	previousDecorationSize = s ifTrue: [ ^ self ].
	previousDecorationSize := s.
	"anEvent currentTarget listElement notifyPrimarySelectionDirty."
	^ self
]

{ #category : #'infinite event handling' }
ToListInnerContainerEventHandler >> infiniteElementAttachedEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent:
		(ToListNodeAddedEvent new
			 node: anEvent element;
			 yourself)
]

{ #category : #'infinite event handling' }
ToListInnerContainerEventHandler >> infiniteElementDetachedEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent:
		(ToListNodeRemovedEvent new
			 node: anEvent element;
			 yourself)
]

{ #category : #'infinite event handling' }
ToListInnerContainerEventHandler >> infiniteScrollFinishedEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent: anEvent
]
