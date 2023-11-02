Class {
	#name : #ToDeselectedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToDeselectedLookEvent >> sendTo: anObject [

	anObject deselectedLookEvent: self
]
