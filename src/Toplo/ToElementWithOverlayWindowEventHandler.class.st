Class {
	#name : #ToElementWithOverlayWindowEventHandler,
	#superclass : #ToElementWithAnchoredWindowEventHandler,
	#category : #'Toplo-Core-Window'
}

{ #category : #'element handlers' }
ToElementWithOverlayWindowEventHandler >> elementExtentChangedEvent: anEvent [

	self window size: self window associateElement size
]

{ #category : #'api - accessing' }
ToElementWithOverlayWindowEventHandler >> eventsToHandle [ 

	^ super eventsToHandle , { BlElementExtentChangedEvent }
]
