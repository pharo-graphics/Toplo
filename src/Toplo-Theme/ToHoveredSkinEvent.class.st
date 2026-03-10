Class {
	#name : #ToHoveredSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToHoveredSkinEvent >> sendTo: anObject [

	anObject hoveredSkinEvent: self
]
