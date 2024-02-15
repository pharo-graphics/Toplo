Class {
	#name : #ToStillPressedLookEvent,
	#superclass : #ToTransientLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToStillPressedLookEvent >> sendTo: anObject [

	anObject stillPressedLookEvent: self
]
