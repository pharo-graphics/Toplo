Class {
	#name : #ToSkinManagementEvent,
	#superclass : #BlEvent,
	#instVars : [
		'skin'
	],
	#category : #'Toplo-Core-Skin'
}

{ #category : #sending }
ToSkinManagementEvent >> sendToStyleSheetSkin: aStyleSheetSkin [

	self sendTo: aStyleSheetSkin 
]

{ #category : #accessing }
ToSkinManagementEvent >> skin [

	^ skin
]

{ #category : #accessing }
ToSkinManagementEvent >> skin: aSkin [

	skin := aSkin
]
