Class {
	#name : #ToStartStillPressedEvent,
	#superclass : #ToGeneratorEvent,
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #sending }
ToStartStillPressedEvent >> sendTo: anObject [

	anObject startStillPressedEvent: self
]
