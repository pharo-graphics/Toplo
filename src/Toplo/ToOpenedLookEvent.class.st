Class {
	#name : #ToOpenedLookEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #testing }
ToOpenedLookEvent class >> isDeprecated [ 

	^ true
]

{ #category : #sending }
ToOpenedLookEvent >> sendTo: anObject [

	anObject openedSkinEvent: self
]
