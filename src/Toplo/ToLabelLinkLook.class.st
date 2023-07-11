Class {
	#name : #ToLabelLinkLook,
	#superclass : #ToLabelLookDecorator,
	#category : #'Toplo-Widget-Label-Look'
}

{ #category : #'event handling' }
ToLabelLinkLook >> mouseHoverLookEvent: anEvent [

	super mouseHoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| builder |
		builder := self decoratedTextAttributesBuilderFromElement: e.
		builder foreground: e toTheme colorLinkHover.
		e text attributes: builder attributes.
		e textChanged ]
]

{ #category : #'event handling' }
ToLabelLinkLook >> mousePressedLookEvent: anEvent [

	super mousePressedLookEvent: anEvent.
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
