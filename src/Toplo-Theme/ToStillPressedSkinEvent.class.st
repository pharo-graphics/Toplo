Class {
	#name : #ToStillPressedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToStillPressedSkinEvent >> sendTo: anObject [

	anObject stillPressedSkinEvent: self
]
