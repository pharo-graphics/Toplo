Class {
	#name : #ToSkinChangedEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Theme-Core'
}

{ #category : #sending }
ToSkinChangedEvent >> sendTo: anObject [

	anObject skinChangedEvent: self
]
