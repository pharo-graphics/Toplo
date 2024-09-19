Class {
	#name : #ToWindowOpenedEvent,
	#superclass : #ToWindowEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToWindowOpenedEvent >> sendTo: anObject [

	Error signal: 'Abstract event'
]
