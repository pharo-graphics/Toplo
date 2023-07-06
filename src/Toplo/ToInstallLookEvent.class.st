Class {
	#name : #ToInstallLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #sending }
ToInstallLookEvent >> sendToLook: aLook [

	aLook installLookEvent: self
]
