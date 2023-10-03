Class {
	#name : #ToWidgetInAnchoredWindowEventHandler,
	#superclass : #ToWidgetInWindowEventHandler,
	#category : #'Toplo-Core-Window'
}

{ #category : #'event handling' }
ToWidgetInAnchoredWindowEventHandler >> elementPositionInSpaceChangedEvent: anEvent [

	self window position: (self window positionHook value: self window value: anEvent)
]

{ #category : #'api - accessing' }
ToWidgetInAnchoredWindowEventHandler >> eventsToHandle [ 

	^ super eventsToHandle , { BlElementPositionInSpaceChangedEvent }
]
