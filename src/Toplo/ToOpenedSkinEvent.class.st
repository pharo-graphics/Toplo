Class {
	#name : #ToOpenedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToOpenedSkinEvent >> sendTo: anObject [

	anObject openedSkinEvent: self
]
