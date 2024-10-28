Class {
	#name : #ToStopStillPressedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToStopStillPressedSkinEvent >> sendTo: anObject [

	anObject stopStillPressedSkinEvent: self
]
