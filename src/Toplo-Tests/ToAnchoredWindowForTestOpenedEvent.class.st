Class {
	#name : #ToAnchoredWindowForTestOpenedEvent,
	#superclass : #ToAnchoredWindowOpenedEvent,
	#category : #'Toplo-Tests-Core-Window'
}

{ #category : #sending }
ToAnchoredWindowForTestOpenedEvent >> sendTo: anObject [

	anObject windowOpenedEvent: self
]
