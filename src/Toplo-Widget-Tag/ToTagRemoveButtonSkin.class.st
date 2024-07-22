Class {
	#name : #ToTagRemoveButtonSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Tag'
}

{ #category : #'event handling' }
ToTagRemoveButtonSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
		e mouseCursor: Cursor webLink.
		e border: (Color red alpha: 0.5) ]
]

{ #category : #'event handling' }
ToTagRemoveButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon formColor: Color gray.
		e vFitContent.
		e geometry: BlCircleGeometry new.
		e border: BlBorder empty.
		e padding: BlInsets empty ]
]

{ #category : #'event handling' }
ToTagRemoveButtonSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal.
		e border: BlBorder empty ]
]
