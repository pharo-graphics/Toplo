Class {
	#name : #ToSkinManagementEvent,
	#superclass : #BlEvent,
	#category : 'Toplo-Core-Theme'
}

{ #category : #sending }
ToSkinManagementEvent >> sendToStyleSheetSkin: aStyleSheetSkin [

	self sendTo: aStyleSheetSkin 
]
