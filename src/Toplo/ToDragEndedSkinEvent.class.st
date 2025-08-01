Class {
	#name : #ToDragEndedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToDragEndedSkinEvent >> sendTo: anObject [

	anObject dragEndedSkinEvent: self
]
