Class {
	#name : #ToLabelSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #'event handling' }
ToLabelSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e textAttributesBuilder 
			weight: (e valueOfTokenNamed: #'font-weight-strong');
			defaultFontName: (e valueOfTokenNamed: #'font-family-code');
			defaultFontSize: (e valueOfTokenNamed: #'font-size');
			lineSpacing: (e valueOfTokenNamed: #'line-height');
			foreground: (e valueOfTokenNamed: #'color-text').
		e isDisabled ifTrue: [
			e textAttributesBuilder foreground: (e valueOfTokenNamed: #'color-text-disabled') ].
		e hasText ifFalse: [ ^ self ].
		e applyAttributesBuilder.
		e textChanged ]
]
