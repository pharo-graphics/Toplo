Class {
	#name : 'ToDragStartedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToDragStartedLookEvent >> sendTo: anObject [

	anObject dragStartedLookEvent: self
]
