Class {
	#name : 'ToUnfocusedLookEvent',
	#superclass : 'ToIntrasicStateLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToUnfocusedLookEvent >> sendTo: anObject [

	anObject unfocusedLookEvent: self
]
