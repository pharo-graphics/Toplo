Class {
	#name : #ToSkinUninstallStateRequest,
	#superclass : #ToSkinManagementEvent,
	#category : 'Toplo-Core-Theme'
}

{ #category : #sending }
ToSkinUninstallStateRequest >> sendTo: anObject [

	anObject skinUninstallStateRequest: self
]
