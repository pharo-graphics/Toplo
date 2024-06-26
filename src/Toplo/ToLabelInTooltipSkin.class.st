Class {
	#name : #ToLabelInTooltipSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #'event handling' }
ToLabelInTooltipSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e textAttributesBuilder 
			weight: (e valueOfTokenNamed: #'font-weight-strong');
			defaultFontName: (e valueOfTokenNamed: #'font-family-code');
			defaultFontSize: (e valueOfTokenNamed: #'font-size-in-tooltip');
			lineSpacing: (e valueOfTokenNamed: #'line-height');
			foreground: (e valueOfTokenNamed: #'text-foreground-in-tooltip').
		e hasText ifFalse: [ ^ self ].
		e applyAttributesBuilder.
		e textChanged ]
]
