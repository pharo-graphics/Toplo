Class {
	#name : 'ToReleasedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToReleasedLookEvent >> sendTo: anObject [

	anObject releasedLookEvent: self
]
