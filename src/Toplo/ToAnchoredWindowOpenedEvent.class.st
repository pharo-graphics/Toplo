Class {
	#name : #ToAnchoredWindowOpenedEvent,
	#superclass : #ToAnchoredWindowOpeningEvent,
	#category : #'Toplo-Core-Window'
}

{ #category : #sending }
ToAnchoredWindowOpenedEvent >> sendTo: anObject [

	anObject windowOpenedEvent: self
]
