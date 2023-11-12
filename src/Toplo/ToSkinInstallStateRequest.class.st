Class {
	#name : #ToSkinInstallStateRequest,
	#superclass : #ToSkinEvent,
	#category : 'Toplo-Core-Theme'
}

{ #category : #sending }
ToSkinInstallStateRequest >> sendTo: anObject [

	anObject skinInstallStateRequest: self
]
