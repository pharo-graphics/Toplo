Class {
	#name : #ToAnchoredWindowForTestOpenedEvent,
	#superclass : #ToWindowOpenedEvent,
	#category : #'Toplo-Tests-Core-Window'
}

{ #category : #sending }
ToAnchoredWindowForTestOpenedEvent >> sendTo: anObject [

	anObject windowOpenedEvent: self
]
