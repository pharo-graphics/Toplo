Class {
	#name : #ToStartStillPressedEvent,
	#superclass : #ToPressedEvent,
	#category : #'Toplo-Core-States'
}

{ #category : #sending }
ToStartStillPressedEvent >> sendTo: anObject [

	anObject startStillPressedEvent: self
]
