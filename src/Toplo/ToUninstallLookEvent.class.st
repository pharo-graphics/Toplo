Class {
	#name : #ToUninstallLookEvent,
	#superclass : #ToSkinManagementSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #testing }
ToUninstallLookEvent class >> isDeprecated [ 

	^ true
]

{ #category : #sending }
ToUninstallLookEvent >> sendTo: anObject [

	anObject uninstallSkinEvent: self
]
