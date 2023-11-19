Class {
	#name : #ToSkinInstallStateRequest,
	#superclass : #ToSkinManagementEvent,
	#category : 'Toplo-Core-Theme'
}

{ #category : #sending }
ToSkinInstallStateRequest >> sendTo: anObject [

	anObject skinInstallStateRequest: self
]
