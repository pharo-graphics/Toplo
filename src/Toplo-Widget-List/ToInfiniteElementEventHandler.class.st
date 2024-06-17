Class {
	#name : #ToInfiniteElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'previousDecorationSize'
	],
	#category : #'Toplo-Widget-List-InnerInfinite'
}

{ #category : #'infinite event handling' }
ToInfiniteElementEventHandler >> elementScrolledEvent: anEvent [

	"anEvent delta isZero ifTrue: [ ^ self ]."
	anEvent currentTarget listElement dispatchEvent: anEvent copy
]

{ #category : #'api - accessing' }
ToInfiniteElementEventHandler >> eventsToHandle [

	^ {
		  ToInfiniteScrollFinishedEvent.
		  ToInfiniteDataSourceEmptinessChangedEvent.
		  BlInfiniteElementAttachedEvent.
		  BlInfiniteElementDetachedEvent.
		  BlElementScrolledEvent.
		  BlInfiniteDecorationBoundsChangedEvent }
]

{ #category : #'infinite event handling' }
ToInfiniteElementEventHandler >> infiniteDataSourceEmptinessChangedEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent: anEvent copy
]

{ #category : #'infinite event handling' }
ToInfiniteElementEventHandler >> infiniteDecorationBoundsChangedEvent: anEvent [

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
	anEvent currentTarget listElement notifyPrimarySelectionDirty.
	^ self
]

{ #category : #'infinite event handling' }
ToInfiniteElementEventHandler >> infiniteElementAttachedEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent:
		(ToListNodeAddedEvent new
			 node: anEvent element;
			 yourself)
]

{ #category : #'infinite event handling' }
ToInfiniteElementEventHandler >> infiniteElementDetachedEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent:
		(ToListNodeRemovedEvent new
			 node: anEvent element;
			 yourself)
]

{ #category : #'infinite event handling' }
ToInfiniteElementEventHandler >> infiniteScrollFinishedEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent: anEvent copy
]
