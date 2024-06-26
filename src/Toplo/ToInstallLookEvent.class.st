Class {
	#name : #ToInstallLookEvent,
	#superclass : #ToSkinManagementSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #testing }
ToInstallLookEvent class >> isDeprecated [ 

	^ true
]

{ #category : #sending }
ToInstallLookEvent >> sendTo: anObject [

	anObject installSkinEvent: self
]
