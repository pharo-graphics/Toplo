Class {
	#name : #ToDisabledLookEvent,
	#superclass : #ToIntrasicStateLookEvent,
	#category : #'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToDisabledLookEvent >> sendTo: anObject [

	anObject disabledLookEvent: self
]
