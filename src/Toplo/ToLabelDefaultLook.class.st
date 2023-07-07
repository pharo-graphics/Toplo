Class {
	#name : #ToLabelDefaultLook,
	#superclass : #ToLabelMainLook,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #'event handling' }
ToLabelDefaultLook >> hoverLookEvent: anEvent [

	super hoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| builder |
		builder := self decoratedTextAttributesBuilderFromElement: e.
		e text attributes: builder attributes.
		e textChanged ]
]

{ #category : #accessing }
ToLabelDefaultLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| builder |
		builder := self decoratedTextAttributesBuilderFromElement: e.
		e text attributes: builder attributes.
		e textChanged]
]

{ #category : #accessing }
ToLabelDefaultLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| builder |
		builder := self decoratedTextAttributesBuilderFromElement: e.
		e text attributes: builder attributes.
		e textChanged]
]

{ #category : #'event handling' }
ToLabelDefaultLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| builder |
		builder := self decoratedTextAttributesBuilderFromElement: e.
		e text attributes: builder attributes.
		e textChanged ]
]

{ #category : #accessing }
ToLabelDefaultLook >> textAttributesBuilderFromElement: anElement [

	| builder |
	builder  := BlTextAttributesBuilder new.
	builder lineSpacing: anElement toTheme lineHeight.
	builder defaultFontSize: anElement toTheme fontSize.
	builder defaultFontName: anElement toTheme fontFamilyCode.
	builder foreground: anElement toTheme colorText.

	^ builder 
]
