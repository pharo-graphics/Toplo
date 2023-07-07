Class {
	#name : #ToLabelLinkLook,
	#superclass : #ToLabelLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #'event handling' }
ToLabelLinkLook >> hoverLookEvent: anEvent [

	super hoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| builder |
		builder := self decoratedTextAttributesBuilderFromElement: e.
		builder foreground: e toTheme colorLinkHover.
		e text attributes: builder attributes.
		e textChanged ]
]

{ #category : #'event handling' }
ToLabelLinkLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| builder |
		builder := self decoratedTextAttributesBuilderFromElement: e.
		builder foreground: e toTheme colorPrimaryPressed.
		e text attributes: builder attributes.
		e textChanged ]
]

{ #category : #accessing }
ToLabelLinkLook >> textAttributesBuilderFromElement: anElement [

	| builder |
	builder  := super textAttributesBuilderFromElement: anElement.
	builder weight: anElement toTheme fontWeightStrong.
	builder foreground: anElement toTheme colorPrimary.
	^ builder
]
