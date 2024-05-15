Class {
	#name : #ToAnchoredWindowCloseRequest,
	#superclass : #ToAnchoredWindowClosingEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToAnchoredWindowCloseRequest >> sendTo: anObject [

	anObject windowCloseRequest: self
]
