Class {
	#name : #ToInstallLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToInstallLookEvent >> sendTo: anObject [

	anObject installLookEvent: self
]
