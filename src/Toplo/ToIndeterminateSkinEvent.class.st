Class {
	#name : #ToIndeterminateSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToIndeterminateSkinEvent >> sendTo: anObject [

	anObject indeterminateSkinEvent: self
]
