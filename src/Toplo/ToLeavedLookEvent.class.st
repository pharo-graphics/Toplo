Class {
	#name : #ToLeavedLookEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #testing }
ToLeavedLookEvent class >> isDeprecated [ 

	^ true
]

{ #category : #sending }
ToLeavedLookEvent >> sendTo: anObject [

	anObject leavedSkinEvent: self
]
