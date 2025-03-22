Class {
	#name : #ToIconicButtonSkin,
	#superclass : #ToRawSkin,
	#instVars : [
		'color'
	],
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #'as yet unclassified' }
ToIconicButtonSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent selectionMode isPrimary ifFalse: [ ^ self ].
	anEvent selectionMode selectionOption isMasked ifTrue: [ ^ self ].
	anEvent selectionMode selectionOption hasEmbeddedRepresentation
		ifTrue: [ ^ self ].
	anEvent elementDo: [ :e | e innerImageColor: color ]
]

{ #category : #'as yet unclassified' }
ToIconicButtonSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e innerImageColor: (e valueOfTokenNamed: #'color-text-disabled') ]
]

{ #category : #'as yet unclassified' }
ToIconicButtonSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e | e innerImageColor: color ]
]

{ #category : #'as yet unclassified' }
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
		e size: ((e valueOfTokenNamed: #'font-size') + pad) asPoint ]
]

{ #category : #'as yet unclassified' }
ToIconicButtonSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e | e mouseCursor: Cursor normal ]
]

{ #category : #'as yet unclassified' }
ToIconicButtonSkin >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.
	anEvent selectionMode isPrimary ifFalse: [ ^ self ].
	anEvent selectionMode selectionOption isMasked ifTrue: [ ^ self ].
	anEvent selectionMode selectionOption hasEmbeddedRepresentation
		ifTrue: [ ^ self ].
	anEvent elementDo: [ :e |
		| foreground |
		anEvent focused
			ifTrue: [
				e
					withStamp: #'selected-focused-foreground'
					do: [ :v | foreground := v ]
					ifNone: [
					foreground := e valueOfTokenNamed: #'label-selected-focused' ] ]
			ifFalse: [
				e
					withStamp: #'selected-unfocused-foreground'
					do: [ :v | foreground := v ]
					ifNone: [
					foreground := e valueOfTokenNamed: #'label-selected-unfocused' ] ].
		e innerImageColor: foreground ]
]
