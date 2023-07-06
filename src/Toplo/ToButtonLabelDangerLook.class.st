Class {
	#name : #ToButtonLabelDangerLook,
	#superclass : #ToLabelLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #'event handling' }
ToButtonLabelDangerLook >> hoverLookEvent: anEvent [

	super hoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| builder |
		builder := self decoratedTextAttributesBuilderFromElement: e.
		builder foreground: e toTheme colorErrorHover.
		e text attributes: builder attributes.
		e textChanged ]
]

{ #category : #'event handling' }
ToButtonLabelDangerLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| builder |
		builder := self decoratedTextAttributesBuilderFromElement: e.
		builder foreground: e toTheme colorError darker.
		e text attributes: builder attributes.
		e textChanged ]
]

{ #category : #'event handling' }
ToButtonLabelDangerLook >> textAttributesBuilderFromElement: anElement [

	| builder |
	builder  := super textAttributesBuilderFromElement: anElement.
	builder weight: anElement toTheme fontWeightStrong.
	^ builder
]
