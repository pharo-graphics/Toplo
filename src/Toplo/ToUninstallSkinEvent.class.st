Class {
	#name : #ToUninstallSkinEvent,
	#superclass : #ToSkinManagementEvent,
	#category : #'Toplo-Core-Skin'
}

{ #category : #sending }
ToUninstallSkinEvent >> sendTo: anObject [

	anObject uninstallSkinEvent: self
]
