Class {
	#name : #ToStillHoveredLookEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #testing }
ToStillHoveredLookEvent class >> isDeprecated [ 

	^ true
]

{ #category : #sending }
ToStillHoveredLookEvent >> sendTo: anObject [

	anObject stillHoveredSkinEvent: self
]
