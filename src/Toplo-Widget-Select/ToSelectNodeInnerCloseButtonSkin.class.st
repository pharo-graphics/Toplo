Class {
	#name : #ToSelectNodeInnerCloseButtonSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #'event handling' }
ToSelectNodeInnerCloseButtonSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e mouseCursor: Cursor webLink.
		e border: (Color red alpha: 0.5) ]
]

{ #category : #'event handling' }
ToSelectNodeInnerCloseButtonSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e vFitContent.
		e geometry: BlCircleGeometry new.
		e border: BlBorder empty.
		e padding: BlInsets empty ]
]

{ #category : #'event handling' }
ToSelectNodeInnerCloseButtonSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal.
		e border: BlBorder empty ]
]
