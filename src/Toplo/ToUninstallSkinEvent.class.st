Class {
	#name : #ToUninstallSkinEvent,
	#superclass : #ToSkinManagementSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToUninstallSkinEvent >> sendTo: anObject [

	anObject uninstallSkinEvent: self
]
