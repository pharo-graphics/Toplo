Class {
	#name : 'ToFocusedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToFocusedLookEvent >> sendTo: anObject [

	anObject focusedLookEvent: self
]
