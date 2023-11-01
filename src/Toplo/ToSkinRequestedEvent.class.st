Class {
	#name : #ToSkinRequestedEvent,
	#superclass : #ToSkinEvent,
	#category : 'Toplo-Core-Skin'
}

{ #category : #sending }
ToSkinRequestedEvent >> sendTo: anObject [

	anObject skinRequestedEvent: self
]
