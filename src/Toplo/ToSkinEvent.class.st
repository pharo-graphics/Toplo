Class {
	#name : 'ToSkinEvent',
	#superclass : 'BlEvent',
	#category : 'Toplo-Core-Skin',
	#package : 'Toplo',
	#tag : 'Core-Skin'
}

{ #category : 'sending' }
ToSkinEvent >> sendToStylelSheetSkin: aStyleSheetSkin [

	self sendTo: aStyleSheetSkin 
]
