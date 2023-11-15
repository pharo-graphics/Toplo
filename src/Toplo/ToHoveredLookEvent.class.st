Class {
	#name : 'ToHoveredLookEvent',
	#superclass : 'ToTransientLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToHoveredLookEvent >> sendTo: anObject [

	anObject hoveredLookEvent: self
]
