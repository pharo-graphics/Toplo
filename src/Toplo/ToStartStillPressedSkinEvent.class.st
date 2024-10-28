Class {
	#name : #ToStartStillPressedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToStartStillPressedSkinEvent >> sendTo: anObject [

	anObject startStillPressedSkinEvent: self
]
