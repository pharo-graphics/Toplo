Class {
	#name : #ToDraggedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToDraggedSkinEvent >> sendTo: anObject [

	anObject draggedSkinEvent: self
]
