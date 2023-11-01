Class {
	#name : #ToSkinChangedEvent,
	#superclass : #ToSkinEvent,
	#category : 'Toplo-Core-Skin'
}

{ #category : #sending }
ToSkinChangedEvent >> sendTo: anObject [

	anObject skinChangedEvent: self
]
