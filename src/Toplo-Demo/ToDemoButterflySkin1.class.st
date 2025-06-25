Class {
	#name : #ToDemoButterflySkin1,
	#superclass : #ToButterflySkin,
	#category : #'Toplo-Demo-2 - ButterflyTheme'
}

{ #category : #'event handling' }
ToDemoButterflySkin1 >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: Color white.
		e border: (BlBorder paint: Color blue width: 4) ]
]

{ #category : #'event handling' }
ToDemoButterflySkin1 >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e geometry: BlCircleGeometry new.
		e background: Color lightGray.
		e border: (BlBorder paint: Color yellow width: 4) ]
]

{ #category : #'event handling' }
ToDemoButterflySkin1 >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: Color lightGray.
		e border: (BlBorder paint: Color yellow width: 4) ]
]

{ #category : #'event handling' }
ToDemoButterflySkin1 >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: Color lightGray.
		e border: (BlBorder paint: Color yellow width: 4) ]
]
