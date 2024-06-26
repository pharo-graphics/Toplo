Class {
	#name : #ToReleasedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToReleasedSkinEvent >> sendTo: anObject [

	anObject releasedLookEvent: self
]
