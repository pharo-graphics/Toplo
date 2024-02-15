Class {
	#name : #ToOpenedLookEvent,
	#superclass : #ToTransientLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToOpenedLookEvent >> sendTo: anObject [

	anObject openedLookEvent: self
]
