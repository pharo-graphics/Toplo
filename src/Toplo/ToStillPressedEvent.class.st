Class {
	#name : #ToStillPressedEvent,
	#superclass : #ToPressedEvent,
	#category : #'Toplo-Core-States'
}

{ #category : #sending }
ToStillPressedEvent >> sendTo: anObject [

	anObject stillPressedEvent: self
]
