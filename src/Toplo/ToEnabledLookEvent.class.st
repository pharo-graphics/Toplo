Class {
	#name : 'ToEnabledLookEvent',
	#superclass : 'ToIntrasicStateLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToEnabledLookEvent >> sendTo: anObject [

	anObject enabledLookEvent: self
]
