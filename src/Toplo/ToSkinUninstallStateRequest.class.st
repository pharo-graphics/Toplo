Class {
	#name : #ToSkinUninstallStateRequest,
	#superclass : #ToSkinManagementEvent,
	#category : #'Toplo-Core-Skin'
}

{ #category : #sending }
ToSkinUninstallStateRequest >> sendTo: anObject [

	anObject skinUninstallStateRequest: self
]
