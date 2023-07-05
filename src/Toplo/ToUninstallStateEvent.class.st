Class {
	#name : #ToUninstallStateEvent,
	#superclass : #ToElementStateEvent,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #accessing }
ToUninstallStateEvent >> sendToLook: aLook [

	aLook uninstallStateEvent: self
]
