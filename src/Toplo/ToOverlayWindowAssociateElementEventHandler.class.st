Class {
	#name : #ToOverlayWindowAssociateElementEventHandler,
	#superclass : #ToAnchoredWindowAssociateElementEventHandler,
	#category : #'Toplo-Core-Window'
}

{ #category : #'element handlers' }
ToOverlayWindowAssociateElementEventHandler >> elementExtentChangedEvent: anEvent [

	self associateWindow applySizeHookFromEvent: anEvent
]

{ #category : #'api - accessing' }
ToOverlayWindowAssociateElementEventHandler >> eventsToHandle [ 

	^ super eventsToHandle , { BlElementExtentChangedEvent }
]
