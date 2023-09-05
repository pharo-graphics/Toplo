Class {
	#name : #ToInstallLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToInstallLookEvent >> sendToLook: aLook [

	aLook installLookEvent: self
]
