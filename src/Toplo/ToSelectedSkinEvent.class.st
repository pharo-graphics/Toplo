Class {
	#name : #ToSelectedSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#instVars : [
		'focused'
	],
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #accessing }
ToSelectedSkinEvent >> focused [

	^ focused
]

{ #category : #accessing }
ToSelectedSkinEvent >> focused: aBoolean [

	focused := aBoolean
]

{ #category : #'instance creation' }
ToSelectedSkinEvent >> fromState: aState [

	super fromState: aState.
	self focused: aState focused
]

{ #category : #sending }
ToSelectedSkinEvent >> sendTo: anObject [

	anObject selectedSkinEvent: self
]
