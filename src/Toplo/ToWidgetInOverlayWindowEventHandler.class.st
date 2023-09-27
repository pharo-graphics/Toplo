Class {
	#name : #ToWidgetInOverlayWindowEventHandler,
	#superclass : #ToWidgetInAnchoredWindowEventHandler,
	#category : #'Toplo-Core-Window'
}

{ #category : #'element handlers' }
ToWidgetInOverlayWindowEventHandler >> elementExtentChangedEvent: anEvent [

	self window size: self window widget size
]

{ #category : #'api - accessing' }
ToWidgetInOverlayWindowEventHandler >> eventsToHandle [ 

	^ super eventsToHandle , { BlElementExtentChangedEvent }
]
