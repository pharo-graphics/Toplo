Class {
	#name : #ToUninstallLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-Skins'
}

{ #category : #sending }
ToUninstallLookEvent >> sendToLook: aLook [

	aLook uninstallLookEvent: self
]
