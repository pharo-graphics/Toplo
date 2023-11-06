Class {
	#name : 'ToDraggedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToDraggedLookEvent >> sendTo: anObject [

	anObject draggedLookEvent: self
]
