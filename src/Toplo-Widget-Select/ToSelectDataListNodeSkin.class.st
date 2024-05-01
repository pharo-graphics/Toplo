Class {
	#name : #ToSelectDataListNodeSkin,
	#superclass : #ToRawSkin,
	#instVars : [
		'originalHeight'
	],
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'event handling' }
ToSelectDataListNodeSkin >> deselectedLookEvent: anEvent [

	super deselectedLookEvent: anEvent.
	anEvent elementDo: [ :e | ]
]

{ #category : #'event handling' }
ToSelectDataListNodeSkin >> selectedLookEvent: anEvent [

	super selectedLookEvent: anEvent.
	anEvent elementDo: [ :e | ]
]
