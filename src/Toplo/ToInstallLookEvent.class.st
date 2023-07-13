Class {
	#name : #ToInstallLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-Look-Events'
}

{ #category : #sending }
ToInstallLookEvent >> sendToLook: aLook [

	aLook installLookEvent: self
]
