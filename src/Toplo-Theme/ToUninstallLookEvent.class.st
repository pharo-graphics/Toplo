Class {
	#name : #ToUninstallLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToUninstallLookEvent >> sendToLook: aLook [

	aLook uninstallLookEvent: self
]
