Class {
	#name : #ToStopStillPressedEvent,
	#superclass : #ToPressedEvent,
	#category : #'Toplo-Core-States'
}

{ #category : #sending }
ToStopStillPressedEvent >> sendTo: anObject [

	anObject stopStillPressedEvent: self
]
