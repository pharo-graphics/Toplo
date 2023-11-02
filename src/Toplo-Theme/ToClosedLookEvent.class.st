Class {
	#name : #ToClosedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToClosedLookEvent >> sendTo: anObject [

	anObject closedLookEvent: self
]
