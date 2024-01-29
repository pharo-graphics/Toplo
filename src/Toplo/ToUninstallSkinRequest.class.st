Class {
	#name : #ToUninstallSkinRequest,
	#superclass : #ToSkinManagementEvent,
	#category : #'Toplo-Core-Skin'
}

{ #category : #sending }
ToUninstallSkinRequest >> sendTo: anObject [

	anObject uninstallSkinRequest: self
]
