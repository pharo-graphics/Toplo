Class {
	#name : #ToInstallLookEvent,
	#superclass : #ToSkinManagementLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToInstallLookEvent >> sendTo: anObject [

	anObject installLookEvent: self
]
