Class {
	#name : #ToInstallLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-Skins'
}

{ #category : #sending }
ToInstallLookEvent >> sendToLook: aLook [

	aLook installLookEvent: self
]
