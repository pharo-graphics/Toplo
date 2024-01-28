Class {
	#name : #ToInstallSkinEvent,
	#superclass : #ToSkinManagementEvent,
	#category : #'Toplo-Core-Skin'
}

{ #category : #sending }
ToInstallSkinEvent >> sendTo: anObject [

	anObject installSkinEvent: self
]
