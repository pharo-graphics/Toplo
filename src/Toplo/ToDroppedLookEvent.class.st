Class {
	#name : 'ToDroppedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToDroppedLookEvent >> sendTo: anObject [

	anObject droppedLookEvent: self
]
