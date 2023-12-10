Class {
	#name : 'ToStyleSheetForTest',
	#superclass : 'ToStyleSheet',
	#category : 'Toplo-Tests-Core-Theme',
	#package : 'Toplo-Tests',
	#tag : 'Core-Theme'
}

{ #category : 'initialization' }
ToStyleSheetForTest >> defaultStyleRules [

	| script |
	script := ToStyleScript new.
	self elementScript: script.
	^ script styleRules
]

{ #category : 'rules declaring' }
ToStyleSheetForTest >> elementScript: aStyleScript [
	" one rule for elements with the stamp #element "

	aStyleScript
		select: #element asStampSelector
		style: [ :scr | " 5 writers - but only 3 of them remain (override) "
			scr write: (self property: #background) with: Color white.
			scr write: (self property: #background) withAll: {
					(ToHoveredLookEvent -> Color blue).
					(ToLeavedLookEvent -> Color red) }.
			scr
				when: ToHoveredLookEvent
				write: (self property: #background)
				with: Color yellow.
			scr
				when: ToLeavedLookEvent
				write: (self property: #background)
				with: Color brown ]
]
