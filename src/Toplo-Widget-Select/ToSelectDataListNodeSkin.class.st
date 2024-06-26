Class {
	#name : #ToSelectDataListNodeSkin,
	#superclass : #ToRawSkin,
	#instVars : [
		'originalHeight'
	],
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'event handling' }
ToSelectDataListNodeSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent elementDo: [ :e | ]
]

{ #category : #'event handling' }
ToSelectDataListNodeSkin >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.
	anEvent elementDo: [ :e | ]
]
