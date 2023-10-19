Class {
	#name : #ToSkinChangedEvent,
	#superclass : #BlEvent,
	#category : 'Toplo-Core-Skin'
}

{ #category : #sending }
ToSkinChangedEvent >> sendTo: anObject [

	anObject skinChangedEvent: self
]
