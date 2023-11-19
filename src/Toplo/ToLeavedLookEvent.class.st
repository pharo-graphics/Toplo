Class {
	#name : 'ToLeavedLookEvent',
	#superclass : 'ToTransientLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToLeavedLookEvent >> sendTo: anObject [

	anObject leavedLookEvent: self 
]
