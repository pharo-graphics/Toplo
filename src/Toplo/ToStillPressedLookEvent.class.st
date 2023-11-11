Class {
	#name : 'ToStillPressedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToStillPressedLookEvent >> sendTo: anObject [

	anObject stillPressedLookEvent: self
]
