Class {
	#name : 'ToWindowRequest',
	#superclass : 'ToWindowOpeningEvent',
	#category : 'Toplo-Core-Window',
	#package : 'Toplo',
	#tag : 'Core-Window'
}

{ #category : 'sending' }
ToWindowRequest >> sendTo: anObject [

	anObject windowRequest: self
]
