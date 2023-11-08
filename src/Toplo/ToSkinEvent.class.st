Class {
	#name : 'ToSkinEvent',
	#superclass : 'BlEvent',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'sending' }
ToSkinEvent >> sendToStylelSheetSkin: aStyleSheetSkin [

	self sendTo: aStyleSheetSkin 
]
