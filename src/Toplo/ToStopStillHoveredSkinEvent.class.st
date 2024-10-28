Class {
	#name : #ToStopStillHoveredSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToStopStillHoveredSkinEvent >> sendTo: anObject [

	anObject stopStillHoveredSkinEvent: self
]
