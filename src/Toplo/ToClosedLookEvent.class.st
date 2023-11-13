Class {
	#name : 'ToClosedLookEvent',
	#superclass : 'ToTransientLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToClosedLookEvent >> sendTo: anObject [

	anObject closedLookEvent: self
]
