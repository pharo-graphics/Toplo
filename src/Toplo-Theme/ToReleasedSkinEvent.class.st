Class {
	#name : #ToReleasedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToReleasedSkinEvent >> sendTo: anObject [

	anObject releasedSkinEvent: self
]
