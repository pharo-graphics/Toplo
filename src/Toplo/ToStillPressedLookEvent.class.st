Class {
	#name : #ToStillPressedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToStillPressedLookEvent >> sendTo: anObject [

	anObject stillPressedLookEvent: self
]
