Class {
	#name : #ToTabInnerCloseButtonSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-TabPaneDeprecated-Skins'
}

{ #category : #testing }
ToTabInnerCloseButtonSkin class >> isDeprecated [ 

	^ true
]

{ #category : #'event handling' }
ToTabInnerCloseButtonSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e | e border: (Color red alpha: 0.5) ]
]

{ #category : #'event handling' }
ToTabInnerCloseButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e vFitContent.
		e geometry: BlCircleGeometry new.
		e border: BlBorder empty.
		e padding: BlInsets empty ]
]

{ #category : #'event handling' }
ToTabInnerCloseButtonSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e | e border: BlBorder empty ]
]

{ #category : #'event handling' }
ToTabInnerCloseButtonSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e | e border: BlBorder empty ]
]
