Class {
	#name : #ToLeftSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToLeftSkinEvent >> sendTo: anObject [

	anObject leftSkinEvent: self
]
