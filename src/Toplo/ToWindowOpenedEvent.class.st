Class {
	#name : 'ToWindowOpenedEvent',
	#superclass : 'ToWindowOpeningEvent',
	#category : 'Toplo-Core-Window',
	#package : 'Toplo',
	#tag : 'Core-Window'
}

{ #category : 'sending' }
ToWindowOpenedEvent >> sendTo: anObject [

	anObject windowOpenedEvent: self
]
