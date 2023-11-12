Class {
	#name : 'ToClickedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToClickedLookEvent >> sendTo: anObject [

	anObject clickedLookEvent: self
]
