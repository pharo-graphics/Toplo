Class {
	#name : #ToStopStillPressedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToStopStillPressedSkinEvent >> sendTo: anObject [

	anObject stopStillPressedSkinEvent: self
]
