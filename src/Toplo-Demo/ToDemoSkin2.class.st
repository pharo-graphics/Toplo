Class {
	#name : #ToDemoSkin2,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Demo-1 - Basic'
}

{ #category : #'event handling' }
ToDemoSkin2 >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent enabledElementDo: [ :e |
		e background: Color red.
		e border: (BlBorder paint: Color blue width: 4) ]
]

{ #category : #'event handling' }
ToDemoSkin2 >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: Color blue.
		e border: (BlBorder paint: Color black width: 1) ]
]

{ #category : #'event handling' }
ToDemoSkin2 >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent enabledElementDo: [ :e |
		e background: Color white.
		e border: (BlBorder paint: Color red width: 1)  ]
]
