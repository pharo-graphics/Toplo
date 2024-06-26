Class {
	#name : #ToFocusedSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToFocusedSkinEvent >> sendTo: anObject [

	anObject focusedSkinEvent: self
]
