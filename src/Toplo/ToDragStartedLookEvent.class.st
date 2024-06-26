Class {
	#name : #ToDragStartedLookEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #testing }
ToDragStartedLookEvent class >> isDeprecated [ 

	^ true
]

{ #category : #sending }
ToDragStartedLookEvent >> sendTo: anObject [

	anObject dragStartedSkinEvent: self
]
