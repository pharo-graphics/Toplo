Class {
	#name : #ToLabelSkin,
	#superclass : #ToRawSkin,
	#instVars : [
		'foreground'
	],
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #'event handling' }
ToLabelSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent selectionMode isPrimary ifFalse: [ ^ self ].
	anEvent selectionMode selectionOption isMasked ifTrue: [ ^ self ].
	anEvent selectionMode selectionOption hasEmbeddedRepresentation ifTrue: [ ^ self ].
	anEvent elementDo: [ :e |
			"e text asString = '2: BB' ifTrue: [ anEvent traceCr ]."
			e foreground: foreground ]
]

{ #category : #'event handling' }
ToLabelSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		"e text asString = '2: BB' ifTrue: [ anEvent traceCr ]."
		e foreground: (e valueOfTokenNamed: #'color-text-disabled') ]
]

{ #category : #'event handling' }
ToLabelSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			"e text asString = '2: BB' ifTrue: [ anEvent traceCr ]."
			e foreground: foreground ]
]

{ #category : #'event handling' }
ToLabelSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			foreground := e valueOfTokenNamed: #'color-text'.
			e textAttributesBuilder
				defaultFontSize: (e valueOfTokenNamed: #'font-size');
				lineSpacing: (e valueOfTokenNamed: #'line-height');
				attribute: (e valueOfTokenNamed: #'font-weight-attribute');
				foreground: foreground.
			e applyStyle ]
]

{ #category : #'event handling' }
ToLabelSkin >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.
	anEvent selectionMode isPrimary ifFalse: [ ^ self ].
	anEvent selectionMode selectionOption isMasked ifTrue: [ ^ self ].
	anEvent selectionMode selectionOption hasEmbeddedRepresentation
		ifTrue: [ ^ self ].
	anEvent elementDo: [ :e |
			| f |
			"e text asString = '2: BB' ifTrue: [ anEvent traceCr ]."
			f := anEvent focused
				     ifTrue: [
				     e valueOfTokenNamed: #'selected-focused-foreground' ]
				     ifFalse: [
				     e valueOfTokenNamed: #'selected-unfocused-foreground' ].
			e foreground: f ]
]
