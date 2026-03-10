Class {
	#name : #ToStillHoveredSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToStillHoveredSkinEvent >> sendTo: anObject [

	anObject stillHoveredSkinEvent: self
]
