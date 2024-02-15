Class {
	#name : #ToDeselectedLookEvent,
	#superclass : #ToIntrasicStateLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToDeselectedLookEvent >> sendTo: anObject [

	anObject deselectedLookEvent: self
]
