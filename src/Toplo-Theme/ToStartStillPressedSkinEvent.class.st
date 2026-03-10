Class {
	#name : #ToStartStillPressedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToStartStillPressedSkinEvent >> sendTo: anObject [

	anObject startStillPressedSkinEvent: self
]
