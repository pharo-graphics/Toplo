Class {
	#name : #ToSkinEvent,
	#superclass : #BlEvent,
	#category : 'Toplo-Core-Theme'
}

{ #category : #sending }
ToSkinEvent >> sendToStyleSheetSkin: aStyleSheetSkin [

	self sendTo: aStyleSheetSkin 
]
