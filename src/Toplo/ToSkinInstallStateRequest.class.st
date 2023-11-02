Class {
	#name : 'ToSkinInstallStateRequest',
	#superclass : 'ToSkinEvent',
	#category : 'Toplo-Core-Skin',
	#package : 'Toplo',
	#tag : 'Core-Skin'
}

{ #category : 'sending' }
ToSkinInstallStateRequest >> sendTo: anObject [

	anObject skinInstallStateRequest: self
]
