Class {
	#name : #ToDisabledLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToDisabledLookEvent >> sendTo: anObject [

	anObject disabledLookEvent: self
]
