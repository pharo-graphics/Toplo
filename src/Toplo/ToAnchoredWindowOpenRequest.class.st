Class {
	#name : #ToAnchoredWindowOpenRequest,
	#superclass : #BlEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToAnchoredWindowOpenRequest >> sendTo: anObject [

	anObject anchoredWindowOpenRequest: self
]
