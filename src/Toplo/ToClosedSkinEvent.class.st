Class {
	#name : #ToClosedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToClosedSkinEvent >> sendTo: anObject [

	anObject closedSkinEvent: self
]
