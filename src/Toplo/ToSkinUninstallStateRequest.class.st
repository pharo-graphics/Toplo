Class {
	#name : 'ToSkinUninstallStateRequest',
	#superclass : 'ToSkinEvent',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'sending' }
ToSkinUninstallStateRequest >> sendTo: anObject [

	anObject skinUninstallStateRequest: self
]
