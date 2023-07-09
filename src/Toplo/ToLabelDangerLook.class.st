Class {
	#name : #ToLabelDangerLook,
	#superclass : #ToLabelLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #'event handling' }
ToLabelDangerLook >> mouseHoverLookEvent: anEvent [

	super mouseHoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| builder |
		builder := self decoratedTextAttributesBuilderFromElement: e.
		builder foreground: e toTheme colorErrorHover.
		e text attributes: builder attributes.
		e textChanged ]
]

{ #category : #'event handling' }
ToLabelDangerLook >> mousePressedLookEvent: anEvent [

	super mousePressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| builder |
		builder := self decoratedTextAttributesBuilderFromElement: e.
		builder foreground: e toTheme colorErrorPressed.
		e text attributes: builder attributes.
		e textChanged ]
]

{ #category : #accessing }
ToLabelDangerLook >> textAttributesBuilderFromElement: anElement [

	| builder |
	builder  := super textAttributesBuilderFromElement: anElement.
	builder weight: anElement toTheme fontWeightStrong.
	builder foreground: anElement toTheme colorError.
	^ builder
]
