Class {
	#name : #ToStyleSheetSkin,
	#superclass : #ToSkin,
	#traits : 'TToSkinEventListenerRegistry + TToStyleSheetSkin',
	#classTraits : 'TToSkinEventListenerRegistry classTrait + TToStyleSheetSkin classTrait',
	#category : #'Toplo-Core-Skin'
}

{ #category : #'api - event managing' }
ToStyleSheetSkin >> handleEvent: anEvent [

	anEvent sendToStyleSheetSkin: self
]
