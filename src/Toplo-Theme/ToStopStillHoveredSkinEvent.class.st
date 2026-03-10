Class {
	#name : #ToStopStillHoveredSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToStopStillHoveredSkinEvent >> sendTo: anObject [

	anObject stopStillHoveredSkinEvent: self
]
