Class {
	#name : #ToAnchoredWindowForTestClosedEvent,
	#superclass : #ToAnchoredWindowClosedEvent,
	#category : #'Toplo-Tests-Core-Window'
}

{ #category : #sending }
ToAnchoredWindowForTestClosedEvent >> sendTo: anObject [

	anObject windowClosedEvent: self
]
