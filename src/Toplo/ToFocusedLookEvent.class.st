Class {
	#name : #ToFocusedLookEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #testing }
ToFocusedLookEvent class >> isDeprecated [ 

	^ true
]

{ #category : #sending }
ToFocusedLookEvent >> sendTo: anObject [

	anObject focusedSkinEvent: self
]
