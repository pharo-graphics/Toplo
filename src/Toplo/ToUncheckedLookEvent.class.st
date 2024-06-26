Class {
	#name : #ToUncheckedLookEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #testing }
ToUncheckedLookEvent class >> isDeprecated [ 

	^ true
]

{ #category : #sending }
ToUncheckedLookEvent >> sendTo: anObject [

	anObject uncheckedSkinEvent: self
]
