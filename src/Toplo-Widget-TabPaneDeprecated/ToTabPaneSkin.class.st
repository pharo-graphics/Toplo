Class {
	#name : #ToTabPaneSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-TabPaneDeprecated-Skins'
}

{ #category : #testing }
ToTabPaneSkin class >> isDeprecated [ 

	^ true
]

{ #category : #'event handling' }
ToTabPaneSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'color-border')
				 width: (e valueOfTokenNamed: #'line-width')) ]
]
