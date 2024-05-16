Class {
	#name : #ToAnchoredWindowClosedEvent,
	#superclass : #ToAnchoredWindowEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToAnchoredWindowClosedEvent >> sendTo: anObject [

	Error signal: 'Abstract event'
]
