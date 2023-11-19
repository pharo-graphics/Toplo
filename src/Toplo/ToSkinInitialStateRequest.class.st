Class {
	#name : #ToSkinInitialStateRequest,
	#superclass : #ToSkinManagementEvent,
	#category : 'Toplo-Core-Theme'
}

{ #category : #sending }
ToSkinInitialStateRequest >> sendTo: anObject [

	anObject skinInitialStateRequest: self
]
