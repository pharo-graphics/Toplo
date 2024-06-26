Class {
	#name : #ToStillPressedLookEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #testing }
ToStillPressedLookEvent class >> isDeprecated [ 

	^ true
]

{ #category : #sending }
ToStillPressedLookEvent >> sendTo: anObject [

	anObject stillPressedSkinEvent: self
]
