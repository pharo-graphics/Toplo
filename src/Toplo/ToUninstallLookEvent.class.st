Class {
	#name : #ToUninstallLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-LookEvents'
}

{ #category : #sending }
ToUninstallLookEvent >> sendToLook: aLook [

	aLook uninstallLookEvent: self
]
