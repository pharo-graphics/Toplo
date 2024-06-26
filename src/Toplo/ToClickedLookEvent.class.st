Class {
	#name : #ToClickedLookEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #testing }
ToClickedLookEvent class >> isDeprecated [ 

	^ true
]

{ #category : #sending }
ToClickedLookEvent >> sendTo: anObject [

	anObject clickedSkinEvent: self
]
