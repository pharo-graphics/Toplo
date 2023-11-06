Class {
	#name : 'ToDisabledLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToDisabledLookEvent >> sendTo: anObject [

	anObject disabledLookEvent: self
]
