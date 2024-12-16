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

	parentBar ifNil: [ ^ self ].
	"parentBar dispatchEvent: anEvent"
]

{ #category : #'infinite event handling' }
ToScrollableBarEventHandler >> elementScrolledEvent: anEvent [

	parentBar ifNil: [ ^ self ].
	"parentBar dispatchEvent: anEvent"
]

{ #category : #'api - accessing' }
ToScrollableBarEventHandler >> eventsToHandle [

	^ {
		  BlBoundsHasChangedDuringScrollingEvent.
		  BlElementScrolledEvent.
		  ToInfiniteScrollFinishedEvent }
]

{ #category : #'infinite event handling' }
ToScrollableBarEventHandler >> infiniteScrollFinishedEvent: anEvent [

	"parentBar dispatchEvent: anEvent"
]

{ #category : #accessing }
ToScrollableBarEventHandler >> parentBar: anInnerBarElement [

	parentBar := anInnerBarElement
]
