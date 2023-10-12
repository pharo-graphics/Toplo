Class {
	#name : #ToReleasedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToReleasedLookEvent >> sendTo: anObject [

	anObject releasedLookEvent: self
]
