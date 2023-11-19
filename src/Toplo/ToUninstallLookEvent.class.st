Class {
	#name : #ToUninstallLookEvent,
	#superclass : #ToSkinManagementLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToUninstallLookEvent >> sendTo: anObject [

	anObject uninstallLookEvent: self
]
