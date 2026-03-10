Class {
	#name : #ToPressedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToPressedSkinEvent >> sendTo: anObject [

	anObject pressedSkinEvent: self
]
