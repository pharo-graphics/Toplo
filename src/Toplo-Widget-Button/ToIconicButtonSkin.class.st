Class {
	#name : #ToIconicButtonSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #'as yet unclassified' }
ToIconicButtonSkin >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	anEvent selectionMode isPrimary ifFalse: [ ^ self ].
	anEvent selectionMode selectionOption isMasked ifTrue: [ ^ self ].
	anEvent selectionMode selectionOption hasEmbeddedRepresentation
		ifTrue: [ ^ self ].
	anEvent elementDo: [ :e |
		e innerImageColor: (e valueOfTokenNamed: #'color-text') ]
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
	anEvent elementDo: [ :e |
		e innerImageColor: (e valueOfTokenNamed: #'color-text') ]
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
		e size: (e valueOfTokenNamed: #'font-size') asPoint ]
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
			foreground := e valueOfTokenNamed: #'label-selected-focused' ]
			ifFalse: [
			foreground := e valueOfTokenNamed: #'label-selected-unfocused' ].
		e innerImageColor: foreground ]
]
