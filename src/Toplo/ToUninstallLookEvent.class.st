Class {
	#name : #ToUninstallLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #sending }
ToUninstallLookEvent >> sendToLook: aLook [

	aLook uninstallLookEvent: self
]
