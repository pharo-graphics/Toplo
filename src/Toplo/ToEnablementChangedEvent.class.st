Class {
	#name : 'ToEnablementChangedEvent',
	#superclass : 'BlEvent',
	#category : 'Toplo-Core',
	#package : 'Toplo',
	#tag : 'Core'
}

{ #category : 'sending' }
ToEnablementChangedEvent >> sendTo: anObject [

	anObject enablementChangedEvent: self
]
