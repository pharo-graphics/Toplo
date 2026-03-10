Class {
	#name : #ToDragHoveredSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToDragHoveredSkinEvent >> sendTo: anObject [

	anObject dragHoveredSkinEvent: self
]
