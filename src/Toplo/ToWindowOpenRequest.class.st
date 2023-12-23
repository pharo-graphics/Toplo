Class {
	#name : 'ToWindowOpenRequest',
	#superclass : 'ToWindowOpeningEvent',
	#category : 'Toplo-Core-Window',
	#package : 'Toplo',
	#tag : 'Core-Window'
}

{ #category : 'sending' }
ToWindowOpenRequest >> sendTo: anObject [

	anObject windowOpenRequest: self
]
