Class {
	#name : 'ToCheckedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToCheckedLookEvent >> sendTo: anObject [

	anObject checkedLookEvent: self
]
