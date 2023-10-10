Class {
	#name : #ToWindowOpenedEvent,
	#superclass : #ToWindowOpeningEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToWindowOpenedEvent >> sendTo: anObject [

	anObject windowOpenedEvent: self
]
