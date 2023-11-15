Class {
	#name : 'ToPressedLookEvent',
	#superclass : 'ToTransientLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToPressedLookEvent >> sendTo: anObject [

	anObject pressedLookEvent: self
]
