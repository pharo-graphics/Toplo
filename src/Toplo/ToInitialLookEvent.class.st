Class {
	#name : 'ToInitialLookEvent',
	#superclass : 'ToSkinManagementLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToInitialLookEvent >> sendTo: anObject [

	anObject initialLookEvent: self
]
