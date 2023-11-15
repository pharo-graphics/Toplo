Class {
	#name : 'ToSkinInstallStateRequest',
	#superclass : 'ToSkinEvent',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'sending' }
ToSkinInstallStateRequest >> sendTo: anObject [

	anObject skinInstallStateRequest: self
]
