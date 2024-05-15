Class {
	#name : #ToAnchoredWindowOpenRequest,
	#superclass : #ToAnchoredWindowOpeningEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToAnchoredWindowOpenRequest >> sendTo: anObject [

	anObject windowOpenRequest: self
]
