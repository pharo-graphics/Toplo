Class {
	#name : #ToUnfocusedSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToUnfocusedSkinEvent >> sendTo: anObject [

	anObject unfocusedSkinEvent: self
]
