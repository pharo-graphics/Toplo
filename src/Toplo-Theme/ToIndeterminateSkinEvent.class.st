Class {
	#name : #ToIndeterminateSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToIndeterminateSkinEvent >> sendTo: anObject [

	anObject indeterminateSkinEvent: self
]
