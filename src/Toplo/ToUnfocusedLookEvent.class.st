Class {
	#name : #ToUnfocusedLookEvent,
	#superclass : #ToIntrasicStateLookEvent,
	#category : #'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToUnfocusedLookEvent >> sendTo: anObject [

	anObject unfocusedLookEvent: self
]
