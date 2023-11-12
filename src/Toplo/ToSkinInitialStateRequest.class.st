Class {
	#name : #ToSkinInitialStateRequest,
	#superclass : #ToSkinEvent,
	#category : 'Toplo-Core-Theme'
}

{ #category : #sending }
ToSkinInitialStateRequest >> sendTo: anObject [

	anObject skinInitialStateRequest: self
]
