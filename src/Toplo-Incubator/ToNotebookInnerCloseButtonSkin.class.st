Class {
	#name : 'ToNotebookInnerCloseButtonSkin',
	#superclass : 'ToRawSkin',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'event handling' }
ToNotebookInnerCloseButtonSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e | e border: (Color red alpha: 0.5) ]
]

{ #category : 'event handling' }
ToNotebookInnerCloseButtonSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e geometry: BlCircleGeometry new.
		e border: BlBorder empty.
		e padding: BlInsets empty ]
]

{ #category : 'event handling' }
ToNotebookInnerCloseButtonSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e | e border: BlBorder empty ]
]
