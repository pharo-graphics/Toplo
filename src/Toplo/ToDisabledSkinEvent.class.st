Class {
	#name : #ToDisabledSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #accessing }
ToDisabledSkinEvent >> enabled [ 

	^ false
]

{ #category : #sending }
ToDisabledSkinEvent >> sendTo: anObject [

	anObject disabledSkinEvent: self
]
