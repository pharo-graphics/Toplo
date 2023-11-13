Class {
	#name : 'ToDisabledLookEvent',
	#superclass : 'ToIntrasicStateLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToDisabledLookEvent >> sendTo: anObject [

	anObject disabledLookEvent: self
]
