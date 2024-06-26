Class {
	#name : #ToCheckedLookEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #testing }
ToCheckedLookEvent class >> isDeprecated [ 

	^ true
]

{ #category : #sending }
ToCheckedLookEvent >> sendTo: anObject [

	anObject checkedSkinEvent: self
]
