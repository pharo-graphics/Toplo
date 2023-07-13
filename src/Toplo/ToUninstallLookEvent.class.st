Class {
	#name : #ToUninstallLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-Look-Events'
}

{ #category : #sending }
ToUninstallLookEvent >> sendToLook: aLook [

	aLook uninstallLookEvent: self
]
