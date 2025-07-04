Class {
	#name : #ToButtonSkin,
	#superclass : #ToGeneralButtonSkin,
	#category : #'Toplo-Widget-Button-Clickable'
}

{ #category : #'event handling' }
ToButtonSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic adaptToColor: (e valueOfTokenNamed: #'color-text-disabled') ].
		e endElementDo: [ :ic |
			(ic respondsTo: #adaptToColor:) ifTrue: [
				ic adaptToColor: (e valueOfTokenNamed: #'color-text-disabled') ] ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text-disabled') ] ]
]

{ #category : #'event handling' }
ToButtonSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e isMenuButton ifFalse: [
			(e hasStamp: #borderless) ifFalse: [
				e border: (BlBorder
						 paint: (e valueOfTokenNamed: #'color-border')
						 width: (e valueOfTokenNamed: #'line-width')) ].
			e iconDo: [ :ic |
				ic adaptToColor: (e valueOfTokenNamed: #'color-text') ] ].
		e endElementDo: [ :ic |
			(ic respondsTo: #adaptToColor:) ifTrue: [
				ic adaptToColor: (e valueOfTokenNamed: #'color-text') ] ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text') ] ]
]

{ #category : #'event handling' }
ToButtonSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e iconDo: [ :ic |
				ic adaptToColor: (e valueOfTokenNamed: #'color-primary') ].
			e endElementDo: [ :ic |
				(ic respondsTo: #adaptToColor:) ifTrue: [
					ic adaptToColor: (e valueOfTokenNamed: #'color-primary') ] ].
			e labelDo: [ :lab |
				lab foreground: (e valueOfTokenNamed: #'color-primary') ] ]
]

{ #category : #'event handling' }
ToButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.

	anEvent elementDo: [ :e |
		e isMenuButton ifFalse: [
			(e hasIcon and: [ e hasLabel ])
				ifTrue: [
				e startInterspace: (e valueOfTokenNamed: #'button-interspace') ]
				ifFalse: [ e startInterspace: 0 ].
			(e hasEndElement and: [ e hasLabel ])
				ifTrue: [
				e endInterspace: (e valueOfTokenNamed: #'button-interspace') ]
				ifFalse: [ e endInterspace: 0 ] ].
		e endElementDo: [ :ic |
			(ic respondsTo: #adaptToColor:) ifTrue: [
				ic adaptToColor: (e valueOfTokenNamed: #'color-text') ] ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text') ] ]
]

{ #category : #'event handling' }
ToButtonSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic adaptToColor: (e valueOfTokenNamed: #'color-text') ].
		e endElementDo: [ :ic |
			(ic respondsTo: #adaptToColor:) ifTrue: [
				ic adaptToColor: (e valueOfTokenNamed: #'color-text') ] ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text') ] ]
]

{ #category : #'event handling' }
ToButtonSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic adaptToColor: (e valueOfTokenNamed: #'color-text') ].
		e endElementDo: [ :ic |
			(ic respondsTo: #adaptToColor:) ifTrue: [
				ic adaptToColor: (e valueOfTokenNamed: #'color-text') ] ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text') ] ]
]

{ #category : #'event handling' }
ToButtonSkin >> pressedSkinEvent: anEvent [

	super pressedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
			ic adaptToColor: (e valueOfTokenNamed: #'color-primary-pressed') ].
		e endElementDo: [ :ic |
			(ic respondsTo: #adaptToColor:) ifTrue: [
				ic adaptToColor:
					(e valueOfTokenNamed: #'color-primary-pressed') ] ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-primary-pressed') ] ]
]
