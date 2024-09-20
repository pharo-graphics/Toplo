Class {
	#name : #ToAnchoredWindowForTestClosedEvent,
	#superclass : #ToWindowClosedEvent,
	#category : #'Toplo-Tests-Core-Window'
}

{ #category : #sending }
ToAnchoredWindowForTestClosedEvent >> sendTo: anObject [

	anObject windowClosedEvent: self
]
