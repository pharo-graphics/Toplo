Class {
	#name : #ToDragStartedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToDragStartedSkinEvent >> sendTo: anObject [

	anObject dragStartedSkinEvent: self
]
