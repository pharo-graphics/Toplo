Class {
	#name : #ToOpenedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToOpenedSkinEvent >> sendTo: anObject [

	anObject openedSkinEvent: self
]
