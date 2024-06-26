Class {
	#name : #ToDraggedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToDraggedSkinEvent >> sendTo: anObject [

	anObject draggedLookEvent: self
]
