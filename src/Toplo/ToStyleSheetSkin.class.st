Class {
	#name : #ToStyleSheetSkin,
	#superclass : #ToSkin,
	#traits : 'TToLookEventListenerRegistry',
	#classTraits : 'TToLookEventListenerRegistry classTrait',
	#instVars : [
		'lookEventListeners'
	],
	#category : 'Toplo-Core-StyleSheet'
}

{ #category : #'api - event managing' }
ToStyleSheetSkin >> handleEvent: anEvent [

	anEvent sendToStyleSheetSkin: self
]

{ #category : #'t - look event listener registry' }
ToStyleSheetSkin >> rawLookEventListeners [

	^ lookEventListeners
]

{ #category : #'t - look event listener registry' }
ToStyleSheetSkin >> rawLookEventListeners: aLookEventListenerCollection [

	lookEventListeners := aLookEventListenerCollection
]

{ #category : #'hook - event managing' }
ToStyleSheetSkin >> sendEventToPropertyWriters: anEvent [

	self lookEventListeners do: [ :s | s receiveEvent: anEvent  ] 
]
