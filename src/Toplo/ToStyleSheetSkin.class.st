Class {
	#name : #ToStyleSheetSkin,
	#superclass : #ToSkin,
	#traits : 'TToLookEventListenerRegistry',
	#classTraits : 'TToLookEventListenerRegistry classTrait',
	#category : #'Toplo-Core-Skin'
}

{ #category : #'api - event managing' }
ToStyleSheetSkin >> handleEvent: anEvent [

	anEvent sendToStyleSheetSkin: self
]

{ #category : #'hook - event managing' }
ToStyleSheetSkin >> sendEventToPropertyWriters: anEvent [

	self skinEventListeners do: [ :s | s receiveEvent: anEvent  ] 
]
