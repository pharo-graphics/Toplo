Class {
	#name : #ToUninstallLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToUninstallLookEvent >> sendTo: anObject [

	anObject uninstallLookEvent: self
]
