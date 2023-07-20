Class {
	#name : #ToElementSkinChangedEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Core-Theme'
}

{ #category : #sending }
ToElementSkinChangedEvent >> sendTo: anObject [

	anObject elementSkinChangedEvent: self
]
