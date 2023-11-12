Class {
	#name : #ToUninstallLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToUninstallLookEvent >> sendTo: anObject [

	anObject uninstallLookEvent: self
]
