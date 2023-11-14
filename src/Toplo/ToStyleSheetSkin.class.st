Class {
	#name : #ToStyleSheetSkin,
	#superclass : #ToSkin,
	#traits : 'TToPropertyWriterHolder',
	#classTraits : 'TToPropertyWriterHolder classTrait',
	#instVars : [
		'writers'
	],
	#category : 'Toplo-Core-StyleSheet'
}

{ #category : #'api - event managing' }
ToStyleSheetSkin >> handleEvent: anEvent [

	anEvent sendToStyleSheetSkin: self
]

{ #category : #initialization }
ToStyleSheetSkin >> initialize [

	super initialize.
	writers := #(  )
]

{ #category : #'t - property writer holder - accessing' }
ToStyleSheetSkin >> rawWriters [

	^ writers
]

{ #category : #'t - property writer holder - accessing' }
ToStyleSheetSkin >> rawWriters: aPropertyWriterCollection [

	writers := aPropertyWriterCollection asArray
]

{ #category : #'private - event handling' }
ToStyleSheetSkin >> sendEventToWriters: anEvent [

	self writers do: [ :s | s receiveEvent: anEvent  ]
]
