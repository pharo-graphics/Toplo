Class {
	#name : #ToStartStillHoveredSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToStartStillHoveredSkinEvent >> sendTo: anObject [

	anObject startStillHoveredSkinEvent: self
]
