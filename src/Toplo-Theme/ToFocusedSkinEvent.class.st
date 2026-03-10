Class {
	#name : #ToFocusedSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToFocusedSkinEvent >> sendTo: anObject [

	anObject focusedSkinEvent: self
]
