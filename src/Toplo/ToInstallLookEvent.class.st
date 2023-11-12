Class {
	#name : 'ToInstallLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToInstallLookEvent >> sendTo: anObject [

	anObject installLookEvent: self
]
