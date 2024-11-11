Class {
	#name : #ToStillHoveredEvent,
	#superclass : #ToGeneratorEvent,
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #sending }
ToStillHoveredEvent >> sendTo: anObject [

	anObject stillHoveredEvent: self
]
