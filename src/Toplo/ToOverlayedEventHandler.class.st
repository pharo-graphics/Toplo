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
