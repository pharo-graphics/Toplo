Class {
	#name : #ToOverlayWindowOpenedEvent,
	#superclass : #ToAnchoredWindowOpenedEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToOverlayWindowOpenedEvent >> sendTo: anObject [

	anObject overlayWindowOpenedEvent: self
]
