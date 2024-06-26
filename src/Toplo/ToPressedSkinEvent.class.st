Class {
	#name : #ToPressedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToPressedSkinEvent >> sendTo: anObject [

	anObject pressedLookEvent: self
]
