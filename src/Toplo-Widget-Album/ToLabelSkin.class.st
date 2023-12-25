Class {
	#name : #ToLabelSkin,
	#superclass : #ToRawSkin,
	#category : 'Toplo-Widget-Album-Label'
}

{ #category : #'event handling' }
ToLabelSkin >> deselectedLookEvent: anEvent [

	super selectedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e foreground: (e tokenValueNamed: #'color-text').
		e applyAttributesBuilder.
		e textChanged ]
]

{ #category : #'event handling' }
ToLabelSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e
			weight: (e tokenValueNamed: #'font-weight-strong');
			defaultFontName: (e tokenValueNamed: #'font-family-code');
			defaultFontSize: (e tokenValueNamed: #'font-size');
			lineSpacing: (e tokenValueNamed: #'line-height');
			foreground: (e tokenValueNamed: #'color-text').
		(e hasStamp: #tooltip) ifTrue: [
			e
				foreground: (e tokenValueNamed: #'color-text-tooltip');
				defaultFontSize: (e tokenValueNamed: #'font-size-tooltip') ].
		e isDisabled ifTrue: [
			e foreground: (e tokenValueNamed: #'color-text-disabled') ].
		e hasText ifFalse: [ ^ self ].
		e applyAttributesBuilder.
		e textChanged ]
]

{ #category : #'event handling' }
ToLabelSkin >> selectedLookEvent: anEvent [

	super selectedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| tokname |
		tokname := anEvent focused
			           ifTrue: [ #'color-text-list-selection-focused' ]
			           ifFalse: [ #'color-text-list-selection-unfocused' ].
		e foreground: (e tokenValueNamed: tokname).
		e applyAttributesBuilder.
		e textChanged ]
]
