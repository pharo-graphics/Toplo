Class {
	#name : #ToWindowClosedEvent,
	#superclass : #ToWindowClosingEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToWindowClosedEvent >> sendTo: anObject [

	anObject windowClosedEvent: self
]
