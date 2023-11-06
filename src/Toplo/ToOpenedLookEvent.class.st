Class {
	#name : 'ToOpenedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToOpenedLookEvent >> sendTo: anObject [

	anObject openedLookEvent: self
]
