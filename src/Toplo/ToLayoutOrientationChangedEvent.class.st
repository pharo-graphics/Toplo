Class {
	#name : 'ToLayoutOrientationChangedEvent',
	#superclass : 'BlEvent',
	#category : 'Toplo-Core',
	#package : 'Toplo',
	#tag : 'Core'
}

{ #category : 'sending' }
ToLayoutOrientationChangedEvent >> sendTo: anObject [

	anObject layoutOrientationChangedEvent: self
]
