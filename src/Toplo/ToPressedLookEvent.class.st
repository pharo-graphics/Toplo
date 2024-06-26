Class {
	#name : #ToPressedLookEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #testing }
ToPressedLookEvent class >> isDeprecated [ 

	^ true
]

{ #category : #sending }
ToPressedLookEvent >> sendTo: anObject [

	anObject pressedSkinEvent: self
]
