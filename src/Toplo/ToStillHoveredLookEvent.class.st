Class {
	#name : 'ToStillHoveredLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToStillHoveredLookEvent >> sendTo: anObject [

	anObject stillHoveredLookEvent: self
]
