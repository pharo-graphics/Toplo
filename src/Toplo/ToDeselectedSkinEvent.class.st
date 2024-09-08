Class {
	#name : #ToDeselectedSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#instVars : [
		'focused'
	],
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #accessing }
ToDeselectedSkinEvent >> focused [

	^ focused
]

{ #category : #accessing }
ToDeselectedSkinEvent >> focused: aBoolean [

	focused := aBoolean
]

{ #category : #'instance creation' }
ToDeselectedSkinEvent >> fromState: aState [

	super fromState: aState.
	self focused: aState focused
]

{ #category : #sending }
ToDeselectedSkinEvent >> sendTo: anObject [

	anObject deselectedSkinEvent: self
]
