Class {
	#name : #ToDeselectedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToDeselectedLookEvent >> sendTo: anObject [

	anObject deselectedLookEvent: self
]
