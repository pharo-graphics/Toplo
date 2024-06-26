Class {
	#name : #ToDisabledLookEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #testing }
ToDisabledLookEvent class >> isDeprecated [ 

	^ true
]

{ #category : #sending }
ToDisabledLookEvent >> sendTo: anObject [

	anObject disabledSkinEvent: self
]
