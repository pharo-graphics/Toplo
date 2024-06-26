Class {
	#name : #ToReleasedLookEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #testing }
ToReleasedLookEvent class >> isDeprecated [ 

	^ true
]

{ #category : #sending }
ToReleasedLookEvent >> sendTo: anObject [

	anObject releasedSkinEvent: self
]
