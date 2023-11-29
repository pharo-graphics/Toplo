Class {
	#name : 'ToTabPaneSkin',
	#superclass : 'ToRawSkin',
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'event handling' }
ToTabPaneSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder
				 paint: (e tokenValueNamed: #'color-border')
				 width: (e tokenValueNamed: #'line-width')) ]
]
