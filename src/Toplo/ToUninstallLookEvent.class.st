Class {
	#name : #ToUninstallLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #accessing }
ToUninstallLookEvent >> sendToLook: aLook [

	aLook uninstallLookEvent: self
]
