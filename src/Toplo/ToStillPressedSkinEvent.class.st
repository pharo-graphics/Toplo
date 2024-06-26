Class {
	#name : #ToStillPressedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToStillPressedSkinEvent >> sendTo: anObject [

	anObject stillPressedLookEvent: self
]
