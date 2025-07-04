Class {
	#name : #ToLeftSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToLeftSkinEvent >> sendTo: anObject [

	anObject leftSkinEvent: self
]
