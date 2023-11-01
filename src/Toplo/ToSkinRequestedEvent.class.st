Class {
	#name : 'ToSkinRequestedEvent',
	#superclass : 'ToSkinEvent',
	#category : 'Toplo-Core-Skin',
	#package : 'Toplo',
	#tag : 'Core-Skin'
}

{ #category : 'sending' }
ToSkinRequestedEvent >> sendTo: anObject [

	anObject skinRequestedEvent: self
]
