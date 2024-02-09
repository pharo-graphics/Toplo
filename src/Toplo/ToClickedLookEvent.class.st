Class {
	#name : #ToClickedLookEvent,
	#superclass : #ToTransientLookEvent,
	#category : #'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToClickedLookEvent >> sendTo: anObject [

	anObject clickedLookEvent: self
]
