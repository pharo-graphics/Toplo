Class {
	#name : #ToScrollableBarEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'parentBar'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'infinite event handling' }
ToScrollableBarEventHandler >> boundsHasChangedDuringScrollingEvent: anEvent [

	parentBar dispatchEvent: anEvent
]

{ #category : #'infinite event handling' }
ToScrollableBarEventHandler >> elementScrolledEvent: anEvent [

	parentBar dispatchEvent: anEvent
]

{ #category : #'api - accessing' }
ToScrollableBarEventHandler >> eventsToHandle [

	^ {
		  BlMouseWheelEvent.
		  BlBoundsHasChangedDuringScrollingEvent.
		  BlElementScrolledEvent.
		  ToInfiniteScrollFinishedEvent }
]

{ #category : #'infinite event handling' }
ToScrollableBarEventHandler >> infiniteScrollFinishedEvent: anEvent [

	parentBar dispatchEvent: anEvent
]

{ #category : #'mouse handlers' }
ToScrollableBarEventHandler >> mouseWheelEvent: anEvent [
	
	"I implement touch support, so ignore fake mouse wheel events"
	anEvent isTouch
		ifTrue: [ ^ self ].

	anEvent currentTarget smoothScrollBy: (anEvent vector * BlInfiniteMouseScrollListener scrollingVelocity ) negated.
	anEvent consume
]

{ #category : #accessing }
ToScrollableBarEventHandler >> parentBar: anInnerBarElement [

	parentBar := anInnerBarElement
]
