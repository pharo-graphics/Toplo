Class {
	#name : #ToOverlayedEventHandler,
	#superclass : #ToAnchorEventHandler,
	#category : #'Toplo-Core-Window'
}

{ #category : #'element handlers' }
ToOverlayedEventHandler >> elementExtentChangedEvent: anEvent [

	windowManager applySizeHookFromEvent: anEvent
]

{ #category : #'api - accessing' }
ToOverlayedEventHandler >> eventsToHandle [

	^ super eventsToHandle , { BlElementExtentChangedEvent }
]

{ #category : #'window opening - closing handlers' }
ToOverlayedEventHandler >> overlayWindowClosedEvent: anEvent [

	self windowClosedEvent: anEvent
]

{ #category : #'window opening - closing handlers' }
ToOverlayedEventHandler >> overlayWindowOpenedEvent: anEvent [

	self windowOpenedEvent: anEvent
]
