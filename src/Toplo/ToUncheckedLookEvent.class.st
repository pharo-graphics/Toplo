Class {
	#name : 'ToUncheckedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToUncheckedLookEvent >> sendTo: anObject [

	anObject uncheckedLookEvent: self
]
