Class {
	#name : #ToLabelMainLook,
	#superclass : #ToLabelLook,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #'event handling' }
ToLabelMainLook >> hoverLookEvent: anEvent [

	super hoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| builder |
		builder := self decoratedTextAttributesBuilderFromElement: e.
		e text attributes: builder attributes.
		e textChanged ]
]

{ #category : #accessing }
ToLabelMainLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| builder |
		builder := self decoratedTextAttributesBuilderFromElement: e.
		e text attributes: builder attributes.
		e textChanged]
]

{ #category : #accessing }
ToLabelMainLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| builder |
		builder := self decoratedTextAttributesBuilderFromElement: e.
		e text attributes: builder attributes.
		e textChanged]
]

{ #category : #testing }
ToLabelMainLook >> isMain [ 

	^ true
]

{ #category : #'event handling' }
ToLabelMainLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| builder |
		builder := self decoratedTextAttributesBuilderFromElement: e.
		e text attributes: builder attributes.
		e textChanged ]
]

{ #category : #accessing }
ToLabelMainLook >> textAttributesBuilderFromElement: anElement [

	| builder |
	builder  := BlTextAttributesBuilder new.
	builder lineSpacing: anElement toTheme lineHeight.
	builder defaultFontSize: anElement toTheme fontSize.
	builder defaultFontName: anElement toTheme fontFamilyCode.
	builder foreground: anElement toTheme colorText.

	^ builder 
]
