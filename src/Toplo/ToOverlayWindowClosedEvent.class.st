Class {
	#name : #ToOverlayWindowClosedEvent,
	#superclass : #ToWindowClosedEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToOverlayWindowClosedEvent >> sendTo: anObject [

	anObject overlayWindowClosedEvent: self
]
