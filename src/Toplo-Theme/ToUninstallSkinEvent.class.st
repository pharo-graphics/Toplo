Class {
	#name : #ToUninstallSkinEvent,
	#superclass : #ToSkinManagementSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToUninstallSkinEvent >> sendTo: anObject [

	anObject uninstallSkinEvent: self
]
