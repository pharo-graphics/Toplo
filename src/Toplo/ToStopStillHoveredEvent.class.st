Class {
	#name : #ToStopStillHoveredEvent,
	#superclass : #ToGeneratorEvent,
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #sending }
ToStopStillHoveredEvent >> sendTo: anObject [

	anObject stopStillHoveredEvent: self
]
