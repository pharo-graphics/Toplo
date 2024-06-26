Class {
	#name : #ToDeselectedLookEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #testing }
ToDeselectedLookEvent class >> isDeprecated [ 

	^ true
]

{ #category : #sending }
ToDeselectedLookEvent >> sendTo: anObject [

	anObject deselectedSkinEvent: self
]
