Class {
	#name : #ToOverlayWindowClosedEvent,
	#superclass : #ToAnchoredWindowClosedEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToOverlayWindowClosedEvent >> sendTo: anObject [

	anObject overlayWindowClosedEvent: self
]
