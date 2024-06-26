Class {
	#name : #ToUnfocusedSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToUnfocusedSkinEvent >> sendTo: anObject [

	anObject unfocusedSkinEvent: self
]
