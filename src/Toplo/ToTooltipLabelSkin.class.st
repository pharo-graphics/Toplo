Class {
	#name : #ToTooltipLabelSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #'event handling' }
ToTooltipLabelSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e textAttributesBuilder 
			weight: (e tokenValueNamed: #'font-weight-strong');
			defaultFontName: (e tokenValueNamed: #'font-family-code');
			defaultFontSize: (e tokenValueNamed: #'font-size-tooltip');
			lineSpacing: (e tokenValueNamed: #'line-height');
			foreground: (e tokenValueNamed: #'color-text-tooltip').
		e hasText ifFalse: [ ^ self ].
		e applyAttributesBuilder.
		e textChanged ]
]
