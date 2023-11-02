Class {
	#name : #ToSkinInstallStateRequest,
	#superclass : #ToSkinEvent,
	#category : 'Toplo-Core-Skin'
}

{ #category : #sending }
ToSkinInstallStateRequest >> sendTo: anObject [

	anObject skinInstallStateRequest: self
]
