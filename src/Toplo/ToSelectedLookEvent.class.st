Class {
	#name : 'ToSelectedLookEvent',
	#superclass : 'ToIntrasicStateLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToSelectedLookEvent >> sendTo: anObject [

	anObject selectedLookEvent: self
]
