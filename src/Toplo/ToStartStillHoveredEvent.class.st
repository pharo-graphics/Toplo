Class {
	#name : #ToStartStillHoveredEvent,
	#superclass : #ToHoveredEvent,
	#category : #'Toplo-Core-States'
}

{ #category : #sending }
ToStartStillHoveredEvent >> sendTo: anObject [

	anObject startStillHoveredEvent: self
]
