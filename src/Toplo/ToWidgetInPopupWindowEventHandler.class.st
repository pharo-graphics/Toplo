Class {
	#name : #ToWidgetInPopupWindowEventHandler,
	#superclass : #ToWidgetInWindowEventHandler,
	#category : #'Toplo-Core-Window'
}

{ #category : #'event handling' }
ToWidgetInPopupWindowEventHandler >> elementPositionChangedEvent: anEvent [

	self window close
]

{ #category : #'api - accessing' }
ToWidgetInPopupWindowEventHandler >> eventsToHandle [ 

	^ super eventsToHandle , { BlElementPositionChangedEvent }
]
