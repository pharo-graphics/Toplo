Class {
	#name : 'ToSkinRequested',
	#superclass : 'BlEvent',
	#category : 'Toplo-Core-Skin',
	#package : 'Toplo',
	#tag : 'Core-Skin'
}

{ #category : 'sending' }
ToSkinRequested >> sendTo: anObject [

	anObject skinRequested: self
]
