Class {
	#name : #ToStartStillHoveredEvent,
	#superclass : #ToGeneratorEvent,
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #sending }
ToStartStillHoveredEvent >> sendTo: anObject [

	anObject startStillHoveredEvent: self
]
