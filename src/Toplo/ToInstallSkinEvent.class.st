Class {
	#name : #ToInstallSkinEvent,
	#superclass : #ToSkinManagementSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToInstallSkinEvent >> sendTo: anObject [

	anObject installSkinEvent: self
]
