Class {
	#name : 'ToSkinInitialStateRequest',
	#superclass : 'ToSkinEvent',
	#category : 'Toplo-Core-Skin',
	#package : 'Toplo',
	#tag : 'Core-Skin'
}

{ #category : 'sending' }
ToSkinInitialStateRequest >> sendTo: anObject [

	anObject skinInitialStateRequest: self
]
