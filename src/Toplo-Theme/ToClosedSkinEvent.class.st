Class {
	#name : #ToClosedSkinEvent,
	#superclass : #ToTransientSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToClosedSkinEvent >> sendTo: anObject [

	anObject closedSkinEvent: self
]
