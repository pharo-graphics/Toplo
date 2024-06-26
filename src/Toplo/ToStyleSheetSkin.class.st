Class {
	#name : #ToStyleSheetSkin,
	#superclass : #ToSkin,
	#traits : 'TToLookEventListenerRegistry',
	#classTraits : 'TToLookEventListenerRegistry classTrait',
	#instVars : [
		'skinEventListeners'
	],
	#category : #'Toplo-Core-StyleSheet'
}

{ #category : #'api - event managing' }
ToStyleSheetSkin >> handleEvent: anEvent [

	anEvent sendToStyleSheetSkin: self
]

{ #category : #'t - skin event listener registry' }
ToStyleSheetSkin >> rawSkinEventListeners [

	^ skinEventListeners
]

{ #category : #'t - skin event listener registry' }
ToStyleSheetSkin >> rawSkinEventListeners: aSkinEventListenerCollection [

	skinEventListeners := aSkinEventListenerCollection
]

{ #category : #'hook - event managing' }
ToStyleSheetSkin >> sendEventToPropertyWriters: anEvent [

	self skinEventListeners do: [ :s | s receiveEvent: anEvent  ] 
]
