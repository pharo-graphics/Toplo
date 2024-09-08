Class {
	#name : #ToSelectNodeInnerCloseButtonSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'event handling' }
ToSelectNodeInnerCloseButtonSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
		e mouseCursor: Cursor webLink.
		e border: (Color red alpha: 0.5) ]
]

{ #category : #'event handling' }
ToSelectNodeInnerCloseButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon formColor: Color lightGray.
		e vFitContent.
		e geometry: BlCircleGeometry new.
		e border: BlBorder empty.
		e padding: BlInsets empty ]
]

{ #category : #'event handling' }
ToSelectNodeInnerCloseButtonSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal.
		e border: BlBorder empty ]
]
