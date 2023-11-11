Class {
	#name : 'ToIndeterminateLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToIndeterminateLookEvent >> sendTo: anObject [

	anObject indeterminateLookEvent: self
]
