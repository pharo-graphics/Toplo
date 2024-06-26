Class {
	#name : #ToStillHoveredSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToStillHoveredSkinEvent >> sendTo: anObject [

	anObject stillHoveredLookEvent: self
]
