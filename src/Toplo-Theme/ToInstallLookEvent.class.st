Class {
	#name : 'ToInstallLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Theme-Look-Event',
	#package : 'Toplo-Theme',
	#tag : 'Look-Event'
}

{ #category : 'sending' }
ToInstallLookEvent >> sendTo: anObject [

	anObject installLookEvent: self
]
