Class {
	#name : #ToAnchoredWindowClosedEvent,
	#superclass : #ToAnchoredWindowClosingEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToAnchoredWindowClosedEvent >> sendTo: anObject [

	anObject windowClosedEvent: self
]
