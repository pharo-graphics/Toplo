Class {
	#name : #ToInstallLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-LookEvents'
}

{ #category : #sending }
ToInstallLookEvent >> sendToLook: aLook [

	aLook installLookEvent: self
]
