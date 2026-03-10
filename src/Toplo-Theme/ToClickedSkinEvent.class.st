Class {
	#name : #ToClickedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToClickedSkinEvent >> sendTo: anObject [

	anObject clickedSkinEvent: self
]
