Class {
	#name : 'ToEnabledLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToEnabledLookEvent >> sendTo: anObject [

	anObject enabledLookEvent: self
]
