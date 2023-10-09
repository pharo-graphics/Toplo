Class {
	#name : #ToWindowClosedEvent,
	#superclass : #ToWindowElementEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToWindowClosedEvent >> sendTo: anObject [

	anObject windowClosedEvent: self
]
