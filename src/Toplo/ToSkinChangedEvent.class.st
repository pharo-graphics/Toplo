Class {
	#name : #ToSkinChangedEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Core-Theme'
}

{ #category : #sending }
ToSkinChangedEvent >> sendTo: anObject [

	anObject skinChangedEvent: self
]
