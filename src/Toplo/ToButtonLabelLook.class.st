Class {
	#name : #ToButtonLabelLook,
	#superclass : #ToLabelLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #'event handling' }
ToButtonLabelLook >> mouseHoverLookEvent: anEvent [

	super mouseHoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| builder |
		builder := self decoratedTextAttributesBuilderFromElement: e.
		builder foreground: e toTheme colorPrimary.
		e text attributes: builder attributes.
		e textChanged ]
]

{ #category : #'event handling' }
ToButtonLabelLook >> mousePressedLookEvent: anEvent [

	super mousePressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| builder |
		builder := self decoratedTextAttributesBuilderFromElement: e.
		builder foreground: e toTheme colorPrimaryPressed.
		e text attributes: builder attributes.
		e textChanged ]
]

{ #category : #private }
ToButtonLabelLook >> textAttributesBuilderFromElement: anElement [

	| builder |
	builder  := super textAttributesBuilderFromElement: anElement.
	builder weight: anElement toTheme fontWeightStrong.
	builder foreground: anElement toTheme colorText.
	^ builder
]
