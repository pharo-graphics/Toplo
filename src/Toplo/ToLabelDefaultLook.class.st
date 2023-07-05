Class {
	#name : #ToLabelDefaultLook,
	#superclass : #ToLabelLook,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #accessing }
ToLabelDefaultLook >> foregroundHoverFromElement: anElement [

	^ self foregroundInitialFromElement: anElement
]

{ #category : #accessing }
ToLabelDefaultLook >> foregroundInitialFromElement: anElement [

	^ anElement toTheme colorText
]

{ #category : #accessing }
ToLabelDefaultLook >> foregroundPressedFromElement: anElement [

	^ self foregroundInitialFromElement: anElement
]

{ #category : #accessing }
ToLabelDefaultLook >> textAttributesFromElement: anElement [

	| builder |
	builder  := BlTextAttributesBuilder new.
	builder lineSpacing: anElement toTheme lineHeight.
	builder defaultFontSize: anElement toTheme fontSize.
	builder defaultFontName: anElement toTheme fontFamilyCode.
	builder weight: anElement toTheme fontWeightStrong.
	builder foreground: anElement toTheme colorText.

	^ builder attributes
]

{ #category : #accessing }
ToLabelDefaultLook >> textAttributesHoverFromElement: anElement [

	^ self textAttributesFromElement: anElement
]

{ #category : #accessing }
ToLabelDefaultLook >> textAttributesPressedFromElement: anElement [

	^ self textAttributesFromElement: anElement
]
