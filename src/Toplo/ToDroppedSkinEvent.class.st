Class {
	#name : #ToDroppedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToDroppedSkinEvent >> sendTo: anObject [

	anObject droppedSkinEvent: self
]
