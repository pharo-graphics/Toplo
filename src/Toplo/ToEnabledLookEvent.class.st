Class {
	#name : #ToEnabledLookEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #testing }
ToEnabledLookEvent class >> isDeprecated [ 

	^ true
]

{ #category : #sending }
ToEnabledLookEvent >> sendTo: anObject [

	anObject enabledSkinEvent: self
]
