Class {
	#name : #ToClickedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToClickedSkinEvent >> sendTo: anObject [

	anObject clickedSkinEvent: self
]
