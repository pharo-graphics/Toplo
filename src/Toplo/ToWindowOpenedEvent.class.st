Class {
	#name : #ToWindowOpenedEvent,
	#superclass : #ToWindowElementEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToWindowOpenedEvent >> sendTo: anObject [

	anObject windowOpenedEvent: self
]
