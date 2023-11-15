Class {
	#name : 'ToReleasedLookEvent',
	#superclass : 'ToTransientLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToReleasedLookEvent >> sendTo: anObject [

	anObject releasedLookEvent: self
]
