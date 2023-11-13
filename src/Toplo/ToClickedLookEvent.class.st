Class {
	#name : 'ToClickedLookEvent',
	#superclass : 'ToTransientLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToClickedLookEvent >> sendTo: anObject [

	anObject clickedLookEvent: self
]
