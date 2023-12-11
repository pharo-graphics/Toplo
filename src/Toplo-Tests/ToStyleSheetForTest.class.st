Class {
	#name : 'ToStyleSheetForTest',
	#superclass : 'ToStyleSheet',
	#category : 'Toplo-Tests-Core-Theme',
	#package : 'Toplo-Tests',
	#tag : 'Core-Theme'
}

{ #category : 'rules declaring' }
ToStyleSheetForTest >> declareElementRules [
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
ToStyleSheetForTest >> initializeStyleRules [ 

	self declareElementRules
]
