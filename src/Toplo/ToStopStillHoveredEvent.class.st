Class {
	#name : #ToStopStillHoveredEvent,
	#superclass : #ToHoveredEvent,
	#category : #'Toplo-Core-States'
}

{ #category : #sending }
ToStopStillHoveredEvent >> sendTo: anObject [

	anObject stopStillHoveredEvent: self
]
