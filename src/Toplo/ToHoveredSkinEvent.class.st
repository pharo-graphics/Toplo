Class {
	#name : #ToHoveredSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToHoveredSkinEvent >> sendTo: anObject [

	anObject hoveredSkinEvent: self
]
