Class {
	#name : #ToAnchoredWindowOpenedEvent,
	#superclass : #ToAnchoredWindowEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToAnchoredWindowOpenedEvent >> sendTo: anObject [

	Error signal: 'Abstract event'
]
