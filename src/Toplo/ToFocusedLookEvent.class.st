Class {
	#name : #ToFocusedLookEvent,
	#superclass : #ToIntrasicStateLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToFocusedLookEvent >> sendTo: anObject [

	anObject focusedLookEvent: self
]
