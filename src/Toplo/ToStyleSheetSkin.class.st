Class {
	#name : 'ToStyleSheetSkin',
	#superclass : 'ToSkin',
	#traits : 'TToPropertyWritersHolder',
	#classTraits : 'TToPropertyWritersHolder classTrait',
	#instVars : [
		'propertyWriters'
	],
	#category : 'Toplo-Core-StyleSheet',
	#package : 'Toplo',
	#tag : 'Core-StyleSheet'
}

{ #category : 'api - event managing' }
ToStyleSheetSkin >> handleEvent: anEvent [

	anEvent sendToStyleSheetSkin: self
]

{ #category : 'initialization' }
ToStyleSheetSkin >> initialize [

	super initialize.
	self rawPropertyWriters: #(  )
]

{ #category : 't - property writers holder - accessing' }
ToStyleSheetSkin >> rawPropertyWriters [

	^ propertyWriters
]

{ #category : 't - property writers holder - accessing' }
ToStyleSheetSkin >> rawPropertyWriters: aPropertyWriterCollection [

	propertyWriters := aPropertyWriterCollection asArray
]

{ #category : 'hook - event managing' }
ToStyleSheetSkin >> sendEventToPropertyWriters: anEvent [

	self propertyWriters do: [ :s | s receiveEvent: anEvent  ] 
]
