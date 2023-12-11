Class {
	#name : 'ToStyleSheetThemeForTest',
	#superclass : 'ToStyleSheetTheme',
	#category : 'Toplo-Tests-Core-Theme',
	#package : 'Toplo-Tests',
	#tag : 'Core-Theme'
}

{ #category : 'rules declaring' }
ToStyleSheetThemeForTest >> declareElementRules [
	" one rule for elements with the stamp #element "

	self
		select: #element asStampSelector
		style: [  " 5 writers - but only 3 of them remain (override) "
			self write: (self property: #background) with: Color white.
			self write: (self property: #background) withAll: {
					(ToHoveredLookEvent -> Color blue).
					(ToLeavedLookEvent -> Color red) }.
			self
				when: ToHoveredLookEvent
				write: (self property: #background)
				with: Color yellow.
			self
				when: ToLeavedLookEvent
				write: (self property: #background)
				with: Color brown ]
]

{ #category : 'initialization' }
ToStyleSheetThemeForTest >> defaultElementStampsFor: anElement [ 

	^ { #element }
]

{ #category : 'initialization' }
ToStyleSheetThemeForTest >> initializeStyleRules [

	super initializeStyleRules.
	self declareElementRules
]
