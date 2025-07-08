Class {
	#name : #ToIconicButtonSkin,
	#superclass : #ToRawSkin,
	#instVars : [
		'color'
	],
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #'event handling' }
ToIconicButtonSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent selectionMode isPrimary ifFalse: [ ^ self ].
	anEvent selectionMode selectionOption isMasked ifTrue: [ ^ self ].
	anEvent selectionMode selectionOption hasEmbeddedRepresentation
		ifTrue: [ ^ self ].
	anEvent elementDo: [ :e | e innerImageColor: color ]
]

{ #category : #'event handling' }
ToIconicButtonSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e innerImageColor: (e valueOfTokenNamed: #'color-text-disabled') ]
]

{ #category : #'event handling' }
ToIconicButtonSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e | e innerImageColor: color ]
]

{ #category : #'event handling' }
ToIconicButtonSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e | e mouseCursor: Cursor webLink ]
]

{ #category : #'event handling' }
ToIconicButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			| pad |
			pad := e valueOfTokenNamed: #'padding-iconic-button'.
			e geometry: BlCircleGeometry new.
			e padding: (BlInsets all: pad).
			e
				withStamp: #color
				do: [ :v | color := v ]
				ifNone: [ color := e valueOfTokenNamed: #'color-text' ].
			e extent: ((e valueOfTokenNamed: #'font-size') + pad) asPoint ]
]

{ #category : #'event handling' }
ToIconicButtonSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e | e mouseCursor: Cursor normal ]
]

{ #category : #'event handling' }
ToIconicButtonSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e | e mouseCursor: Cursor normal ]
]

{ #category : #'event handling' }
ToIconicButtonSkin >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.
	anEvent selectionMode isPrimary ifFalse: [ ^ self ].
	anEvent selectionMode selectionOption isMasked ifTrue: [ ^ self ].
	anEvent selectionMode selectionOption hasEmbeddedRepresentation
		ifTrue: [ ^ self ].
	anEvent elementDo: [ :e |
		| foreground |
		foreground := anEvent focused
			              ifTrue: [
			              e valueOfTokenNamed: #'selected-focused-foreground' ]
			              ifFalse: [
			              e valueOfTokenNamed: #'selected-unfocused-foreground' ].
		e innerImageColor: foreground ]
]
