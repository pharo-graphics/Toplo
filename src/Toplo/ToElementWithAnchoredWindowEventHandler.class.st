Class {
	#name : #ToElementWithAnchoredWindowEventHandler,
	#superclass : #ToElementWithWindowEventHandler,
	#category : #'Toplo-Core-Window'
}

{ #category : #'event handling' }
ToElementWithAnchoredWindowEventHandler >> elementPositionInSpaceChangedEvent: anEvent [

	self window position: (self window positionHook value: self window value: anEvent)
]

{ #category : #'api - accessing' }
ToElementWithAnchoredWindowEventHandler >> eventsToHandle [ 

	^ super eventsToHandle , { BlElementPositionInSpaceChangedEvent }
]
