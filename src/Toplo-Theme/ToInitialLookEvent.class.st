Class {
	#name : #ToInitialLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToInitialLookEvent >> sendTo: anObject [

	anObject initialLookEvent: self
]
