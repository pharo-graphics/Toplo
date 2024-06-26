Class {
	#name : #ToUnfocusedLookEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #testing }
ToUnfocusedLookEvent class >> isDeprecated [ 

	^ true
]

{ #category : #sending }
ToUnfocusedLookEvent >> sendTo: anObject [

	anObject unfocusedSkinEvent: self
]
