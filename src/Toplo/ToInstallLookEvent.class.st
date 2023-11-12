Class {
	#name : #ToInstallLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToInstallLookEvent >> sendTo: anObject [

	anObject installLookEvent: self
]
