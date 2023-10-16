Class {
	#name : 'ToSkinChangedEvent',
	#superclass : 'BlEvent',
	#category : 'Toplo-Core-Skin',
	#package : 'Toplo',
	#tag : 'Core-Skin'
}

{ #category : 'sending' }
ToSkinChangedEvent >> sendTo: anObject [

	anObject skinChangedEvent: self
]
