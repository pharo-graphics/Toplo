Class {
	#name : #ToDragEndedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToDragEndedSkinEvent >> sendTo: anObject [

	anObject dragEndedSkinEvent: self
]
