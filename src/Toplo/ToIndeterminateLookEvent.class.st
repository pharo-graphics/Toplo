Class {
	#name : #ToIndeterminateLookEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #testing }
ToIndeterminateLookEvent class >> isDeprecated [ 

	^ true
]

{ #category : #sending }
ToIndeterminateLookEvent >> sendTo: anObject [

	anObject indeterminateSkinEvent: self
]
