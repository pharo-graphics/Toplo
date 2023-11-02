Class {
	#name : 'ToStyleSheetSkin',
	#superclass : 'ToSkin',
	#traits : 'TToPropertyWriterHolder',
	#classTraits : 'TToPropertyWriterHolder classTrait',
	#instVars : [
		'writers'
	],
	#category : 'Toplo-Theme-StyleSheet',
	#package : 'Toplo-Theme',
	#tag : 'StyleSheet'
}

{ #category : 'event handling' }
ToStyleSheetSkin >> checkedLookEvent: anEvent [

	self sendEventToWriters: anEvent
]

{ #category : 'event handling' }
ToStyleSheetSkin >> clickedLookEvent: anEvent [

	self sendEventToWriters: anEvent
]

{ #category : 'event handling' }
ToStyleSheetSkin >> closedLookEvent: anEvent [

	self sendEventToWriters: anEvent
]

{ #category : 'event handling' }
ToStyleSheetSkin >> deselectedLookEvent: anEvent [

	self sendEventToWriters: anEvent
]

{ #category : 'event handling' }
ToStyleSheetSkin >> disabledLookEvent: anEvent [

	self sendEventToWriters: anEvent
]

{ #category : 'event handling' }
ToStyleSheetSkin >> elementLookEvent: anEvent [

	self sendEventToWriters: anEvent
]

{ #category : 'event handling' }
ToStyleSheetSkin >> enabledLookEvent: anEvent [

	self sendEventToWriters: anEvent
]

{ #category : 'event handling' }
ToStyleSheetSkin >> focusedLookEvent: anEvent [

	self sendEventToWriters: anEvent
]

{ #category : 'event handling' }
ToStyleSheetSkin >> hoveredLookEvent: anEvent [

	self sendEventToWriters: anEvent
]

{ #category : 'event handling' }
ToStyleSheetSkin >> indeterminateLookEvent: anEvent [

	self sendEventToWriters: anEvent
]

{ #category : 'event handling' }
ToStyleSheetSkin >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	self sendEventToWriters: anEvent
]

{ #category : 'initialization' }
ToStyleSheetSkin >> initialize [

	super initialize.
	writers := #(  )
]

{ #category : 'event handling' }
ToStyleSheetSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	self sendEventToWriters: anEvent
]

{ #category : 'event handling' }
ToStyleSheetSkin >> leavedLookEvent: anEvent [

	self sendEventToWriters: anEvent
]

{ #category : 'event handling' }
ToStyleSheetSkin >> openedLookEvent: anEvent [

	self sendEventToWriters: anEvent
]

{ #category : 'event handling' }
ToStyleSheetSkin >> pressedLookEvent: anEvent [

	self sendEventToWriters: anEvent
]

{ #category : 't - property writer holder - accessing' }
ToStyleSheetSkin >> rawWriters [

	^ writers
]

{ #category : 't - property writer holder - accessing' }
ToStyleSheetSkin >> rawWriters: aPropertyWriterCollection [

	writers := aPropertyWriterCollection asArray
]

{ #category : 'event handling' }
ToStyleSheetSkin >> selectedLookEvent: anEvent [

	self sendEventToWriters: anEvent
]

{ #category : 'private - event handling' }
ToStyleSheetSkin >> sendEventToWriters: anEvent [

	self writers do: [ :s | s receiveEvent: anEvent  ]
]

{ #category : 'event handling' }
ToStyleSheetSkin >> uncheckedLookEvent: anEvent [

	self sendEventToWriters: anEvent
]

{ #category : 'event handling' }
ToStyleSheetSkin >> unfocusedLookEvent: anEvent [

	self sendEventToWriters: anEvent
]

{ #category : 'event handling' }
ToStyleSheetSkin >> uninstallLookEvent: anEvent [

	self sendEventToWriters: anEvent
]
