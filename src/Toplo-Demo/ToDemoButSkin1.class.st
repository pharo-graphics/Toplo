Class {
	#name : #ToDemoButSkin1,
	#superclass : #ToButterflySkin,
	#category : #'Toplo-Demo-2-ButterflyTheme'
}

{ #category : #'event handling' }
ToDemoButSkin1 >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: Color white.
		e border: (BlBorder paint: Color blue width: 4) ]
]

{ #category : #'event handling' }
ToDemoButSkin1 >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e geometry: BlCircleGeometry new.
		e background: Color lightGray.
		e border: (BlBorder paint: Color yellow width: 4) ]
]

{ #category : #'event handling' }
ToDemoButSkin1 >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: Color lightGray.
		e border: (BlBorder paint: Color yellow width: 4) ]
]
