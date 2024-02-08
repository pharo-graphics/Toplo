Class {
	#name : #ToWindowCloseRequest,
	#superclass : #ToWindowClosingEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToWindowCloseRequest >> sendTo: anObject [

	anObject windowCloseRequest: self
]
