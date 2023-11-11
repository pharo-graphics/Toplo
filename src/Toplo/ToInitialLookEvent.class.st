Class {
	#name : 'ToInitialLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToInitialLookEvent >> sendTo: anObject [

	anObject initialLookEvent: self
]
