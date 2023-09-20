Class {
	#name : #ToSkinChangedEvent,
	#superclass : #BlEvent,
	#category : 'Toplo-Theme-Skin'
}

{ #category : #sending }
ToSkinChangedEvent >> sendTo: anObject [

	anObject skinChangedEvent: self
]
