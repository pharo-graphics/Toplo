Class {
	#name : #ToStillHoveredEvent,
	#superclass : #ToHoveredEvent,
	#category : #'Toplo-Core-States'
}

{ #category : #sending }
ToStillHoveredEvent >> sendTo: anObject [

	anObject stillHoveredEvent: self
]
