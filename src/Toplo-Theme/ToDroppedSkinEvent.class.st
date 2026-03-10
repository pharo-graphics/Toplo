Class {
	#name : #ToDroppedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToDroppedSkinEvent >> sendTo: anObject [

	anObject droppedSkinEvent: self
]
