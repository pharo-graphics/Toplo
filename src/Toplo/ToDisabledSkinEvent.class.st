Class {
	#name : #ToDisabledSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToDisabledSkinEvent >> sendTo: anObject [

	anObject disabledSkinEvent: self
]
