Class {
	#name : #ToDragLeftSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToDragLeftSkinEvent >> sendTo: anObject [

	anObject dragLeftSkinEvent: self
]
