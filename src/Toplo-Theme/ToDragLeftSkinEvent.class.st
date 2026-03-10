Class {
	#name : #ToDragLeftSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToDragLeftSkinEvent >> sendTo: anObject [

	anObject dragLeftSkinEvent: self
]
