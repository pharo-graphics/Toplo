Class {
	#name : 'ToTabInnerCloseButtonSkin',
	#superclass : 'ToRawSkin',
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'event handling' }
ToTabInnerCloseButtonSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e | e border: (Color red alpha: 0.5) ]
]

{ #category : 'event handling' }
ToTabInnerCloseButtonSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e vFitContent.
		e geometry: BlCircleGeometry new.
		e border: BlBorder empty.
		e padding: BlInsets empty ]
]

{ #category : 'event handling' }
ToTabInnerCloseButtonSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e | e border: BlBorder empty ]
]
