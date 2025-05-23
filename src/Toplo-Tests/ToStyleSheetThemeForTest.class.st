Class {
	#name : #ToStyleSheetThemeForTest,
	#superclass : #ToStyleSheetTheme,
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #'rules declaring' }
ToStyleSheetThemeForTest >> declareElementRules [
	" one rule for elements with the stamp #element "

	self
		select: #element asStampSelector
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
ToStyleSheetThemeForTest >> defaultElementStampsFor: anElement [ 

	^ { #element }
]

{ #category : #initialization }
ToStyleSheetThemeForTest >> initializeStyleRules [

	super initializeStyleRules.
	self declareElementRules
]
