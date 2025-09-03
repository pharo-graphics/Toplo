Class {
	#name : #ToStyleSheetThemeForTest,
	#superclass : #ToStyleSheetTheme,
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #initialization }
ToStyleSheetThemeForTest >> declareElementRules [
	" one rule for elements with the stamp #element "

	self
		select: (ToElement asTypeSelector exact: false; yourself)
		style: [  " 5 writers - but only 3 of them remain (override) "
			self write: (self property: #background) with: Color white.
			self write: (self property: #background) withAll: {
					(ToHoveredSkinEvent -> Color blue).
					(ToLeftSkinEvent -> Color red) }.
			self
				when: ToHoveredSkinEvent
				write: (self property: #background)
				with: Color yellow.
			self
				when: ToLeftSkinEvent
				write: (self property: #background)
				with: Color brown ]
]

{ #category : #initialization }
ToStyleSheetThemeForTest >> initializeStyleRules [

	super initializeStyleRules.
	self declareElementRules
]
