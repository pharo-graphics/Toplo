Class {
	#name : #ToSkinInstallStateRequest,
	#superclass : #ToSkinManagementEvent,
	#category : #'Toplo-Core-Skin'
}

{ #category : #sending }
ToSkinInstallStateRequest >> sendTo: anObject [

	anObject skinInstallStateRequest: self
]
