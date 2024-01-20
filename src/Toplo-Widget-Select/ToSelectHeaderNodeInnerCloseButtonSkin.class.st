Class {
	#name : #ToSelectHeaderNodeInnerCloseButtonSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #'event handling' }
ToSelectHeaderNodeInnerCloseButtonSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e mouseCursor: Cursor webLink.
		e border: (Color red alpha: 0.5) ]
]

{ #category : #'event handling' }
ToSelectHeaderNodeInnerCloseButtonSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon formColor: Color lightGray.
		e vFitContent.
		e geometry: BlCircleGeometry new.
		e border: BlBorder empty.
		e padding: BlInsets empty ]
]

{ #category : #'event handling' }
ToSelectHeaderNodeInnerCloseButtonSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal.
		e border: BlBorder empty ]
]
