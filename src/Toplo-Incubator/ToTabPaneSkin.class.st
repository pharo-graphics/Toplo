Class {
	#name : 'ToTabPaneSkin',
	#superclass : 'ToRawSkin',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'event handling' }
ToTabPaneSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder
				 paint: (e tokenValueNamed: #'color-border')
				 width: (e tokenValueNamed: #'line-width')) ]
]
