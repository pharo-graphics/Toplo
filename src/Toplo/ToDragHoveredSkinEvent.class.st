Class {
	#name : #ToDragHoveredSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToDragHoveredSkinEvent >> sendTo: anObject [

	anObject dragHoveredSkinEvent: self
]
