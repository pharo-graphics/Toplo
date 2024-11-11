Class {
	#name : #ToStopStillPressedEvent,
	#superclass : #ToGeneratorEvent,
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #sending }
ToStopStillPressedEvent >> sendTo: anObject [

	anObject stopStillPressedEvent: self
]
