Class {
	#name : #ToClosedLookEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #testing }
ToClosedLookEvent class >> isDeprecated [ 

	^ true
]

{ #category : #sending }
ToClosedLookEvent >> sendTo: anObject [

	anObject closedSkinEvent: self
]
