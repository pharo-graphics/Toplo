Class {
	#name : #ToOverlayWindowOpenedEvent,
	#superclass : #ToWindowOpenedEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToOverlayWindowOpenedEvent >> sendTo: anObject [

	anObject overlayWindowOpenedEvent: self
]
