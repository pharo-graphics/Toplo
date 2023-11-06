Class {
	#name : 'ToUninstallLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToUninstallLookEvent >> sendTo: anObject [

	anObject uninstallLookEvent: self
]
