Class {
	#name : #ToSwitchButtonSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Button-Switch'
}

{ #category : #'event handling' }
ToSwitchButtonSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal.
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text-disabled') ].
		e isMenuButton ifFalse: [
			e background: (e valueOfTokenNamed: #'color-bg-container-disabled') ] ]
]

{ #category : #'event handling' }
ToSwitchButtonSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: Color transparent.
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text') ] ]
]

{ #category : #'event handling' }
ToSwitchButtonSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor webLink.
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-primary') ] ]
]

{ #category : #'event handling' }
ToSwitchButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e vFitContent.
		e mouseCursor: Cursor normal.
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: 'border-radius')).
		e border: BlBorder empty.
		e hasLabel
			ifTrue: [
			e startInterspace: (e valueOfTokenNamed: #'button-interspace') ]
			ifFalse: [ e startInterspace: 0 ].
		(e hasEndElement and: [ e hasLabel ])
			ifTrue: [
			e endInterspace: (e valueOfTokenNamed: #'button-interspace') ]
			ifFalse: [ e endInterspace: 0 ].
		(e hasAnyInParentChainSatisfying: [ :p | p isMenuItem ]) ifFalse: [
			e padding: (BlInsets
					 top: (e valueOfTokenNamed: #'padding-content-VXS')
					 left: (e valueOfTokenNamed: #'padding-XS')
					 bottom: (e valueOfTokenNamed: #'padding-content-VXS')
					 right: (e valueOfTokenNamed: #'padding-XS')) ] ]
]

{ #category : #'event handling' }
ToSwitchButtonSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal.
		e isEnabled ifTrue: [ 
			e labelDo: [ :lab |
				lab foreground: (e valueOfTokenNamed: #'color-text') ] ] ]
]

{ #category : #'event handling' }
ToSwitchButtonSkin >> pressedSkinEvent: anEvent [

	super pressedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-primary-pressed') ] ]
]
