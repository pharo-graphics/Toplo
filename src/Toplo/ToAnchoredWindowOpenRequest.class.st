Class {
	#name : #ToAnchoredWindowOpenRequest,
	#superclass : #ToAnchoredWindowEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToAnchoredWindowOpenRequest >> sendTo: anObject [

	Error signal: 'Abstract event'
]
