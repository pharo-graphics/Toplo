Class {
	#name : #ToLabelPrimaryLook,
	#superclass : #ToLabelLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #'event handling' }
ToLabelPrimaryLook >> hoverLookEvent: anEvent [

	super hoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| builder |
		builder := self decoratedTextAttributesBuilderFromElement: e.
		builder foreground: e toTheme colorTextLightSolid.
		e text attributes: builder attributes.
		e textChanged ]
]

{ #category : #'event handling' }
ToLabelPrimaryLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| builder |
		builder := self decoratedTextAttributesBuilderFromElement: e.
		e text attributes: builder attributes.
		e textChanged]
]

{ #category : #'event handling' }
ToLabelPrimaryLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| builder |
		builder := self decoratedTextAttributesBuilderFromElement: e.
		builder foreground: e toTheme colorTextLightSolid.
		e text attributes: builder attributes.
		e textChanged ]
]

{ #category : #private }
ToLabelPrimaryLook >> textAttributesBuilderFromElement: anElement [

	| builder |
	builder  := super textAttributesBuilderFromElement: anElement.
	builder weight: anElement toTheme fontWeightStrong.
	builder foreground: anElement toTheme colorTextLightSolid.
	^ builder
]
