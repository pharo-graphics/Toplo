Class {
	#name : #ToStyleSheetSkin,
	#superclass : #ToSkin,
	#traits : 'TToPropertyWriterHolder',
	#classTraits : 'TToPropertyWriterHolder classTrait',
	#instVars : [
		'writers'
	],
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #'event handling' }
ToStyleSheetSkin >> elementLookEvent: anEvent [

	self writers do: [ :s | s receiveEvent: anEvent  ]
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
