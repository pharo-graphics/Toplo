Class {
	#name : #ToFocusedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToFocusedLookEvent >> sendTo: anObject [

	anObject focusedLookEvent: self
]
