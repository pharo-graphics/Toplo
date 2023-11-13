Class {
	#name : 'ToDeselectedLookEvent',
	#superclass : 'ToIntrasicStateLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToDeselectedLookEvent >> sendTo: anObject [

	anObject deselectedLookEvent: self
]
