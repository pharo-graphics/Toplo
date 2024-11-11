Class {
	#name : #ToStillPressedEvent,
	#superclass : #ToGeneratorEvent,
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #sending }
ToStillPressedEvent >> sendTo: anObject [

	anObject stillPressedEvent: self
]
