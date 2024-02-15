Class {
	#name : #ToStillHoveredLookEvent,
	#superclass : #ToTransientLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToStillHoveredLookEvent >> sendTo: anObject [

	anObject stillHoveredLookEvent: self
]
