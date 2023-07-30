Class {
	#name : #ToBasicLabelSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Label-Skins'
}

{ #category : #accessing }
ToBasicLabelSkin >> textAttributesBuilderFromElement: anElement [

	| builder |
	builder  := BlTextAttributesBuilder new.
	builder weight: anElement toTheme fontWeightStrong.
	builder defaultFontName: anElement toTheme fontFamilyCode.
	^ builder 
]
