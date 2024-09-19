Class {
	#name : #ToWindowClosedEvent,
	#superclass : #ToWindowEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToWindowClosedEvent >> sendTo: anObject [

	Error signal: 'Abstract event'
]
