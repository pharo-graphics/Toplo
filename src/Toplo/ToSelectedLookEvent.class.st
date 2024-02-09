Class {
	#name : #ToSelectedLookEvent,
	#superclass : #ToIntrasicStateLookEvent,
	#instVars : [
		'focused'
	],
	#category : #'Toplo-Core-LookEvents'
}

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

	anObject selectedLookEvent: self
]
