Class {
	#name : #ToInstallSkinEvent,
	#superclass : #ToSkinManagementSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToInstallSkinEvent >> sendTo: anObject [

	anObject installSkinEvent: self
]
