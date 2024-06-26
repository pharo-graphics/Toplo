Class {
	#name : #ToDragStartedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToDragStartedSkinEvent >> sendTo: anObject [

	anObject dragStartedSkinEvent: self
]
