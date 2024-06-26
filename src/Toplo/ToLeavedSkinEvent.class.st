Class {
	#name : #ToLeavedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToLeavedSkinEvent >> sendTo: anObject [

	anObject leavedSkinEvent: self
]
