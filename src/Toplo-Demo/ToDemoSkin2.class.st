Class {
	#name : #ToDemoSkin2,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Demo-1-Basic'
}

{ #category : #'event handling' }
ToDemoSkin2 >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: Color red.
		e border: (BlBorder paint: Color blue width: 4) ]
]

{ #category : #'event handling' }
ToDemoSkin2 >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: Color blue.
		e border: (BlBorder paint: Color black width: 1) ]
]

{ #category : #'event handling' }
ToDemoSkin2 >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: Color white.
		e border: (BlBorder paint: Color red width: 1)  ]
]
