Class {
	#name : #ToLabelInTooltipSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #'event handling' }
ToLabelInTooltipSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e textAttributesBuilder 
			weight: (e tokenValueNamed: #'font-weight-strong');
			defaultFontName: (e tokenValueNamed: #'font-family-code');
			defaultFontSize: (e tokenValueNamed: #'font-size-in-tooltip');
			lineSpacing: (e tokenValueNamed: #'line-height');
			foreground: (e tokenValueNamed: #'text-foreground-in-tooltip').
		e hasText ifFalse: [ ^ self ].
		e applyAttributesBuilder.
		e textChanged ]
]
