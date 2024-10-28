Class {
	#name : #ToStartStillHoveredSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToStartStillHoveredSkinEvent >> sendTo: anObject [

	anObject startStillHoveredSkinEvent: self
]
