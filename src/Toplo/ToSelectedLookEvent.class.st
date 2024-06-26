Class {
	#name : #ToSelectedLookEvent,
	#superclass : #ToIntrasicSkinEvent,
	#instVars : [
		'focused'
	],
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #testing }
ToSelectedLookEvent class >> isDeprecated [ 

	^ true
]

{ #category : #accessing }
ToSelectedLookEvent >> focused [

	^ focused
]

{ #category : #accessing }
ToSelectedLookEvent >> focused: aBoolean [

	focused := aBoolean
]

{ #category : #'instance creation' }
ToSelectedLookEvent >> fromState: aState [

	super fromState: aState.
	self focused: aState focused
]

{ #category : #sending }
ToSelectedLookEvent >> sendTo: anObject [

	anObject selectedSkinEvent: self
]
