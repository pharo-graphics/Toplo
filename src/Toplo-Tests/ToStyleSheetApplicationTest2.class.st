Class {
	#name : #ToStyleSheetApplicationTest2,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core-StyleSheet'
}

{ #category : #tests }
ToStyleSheetApplicationTest2 >> testApplicationOnElement [

	| theme elem |
	theme := ToStyleSheetTheme new.
	" default one rule "
	theme addWritableProperty: (ToFeatureProperty name: #background).
	theme select: ToElement asTypeSelector style: [ :sr |
		sr
			when: ToInstallSkinEvent
			write: (theme property: #background)
			with: [ :e | Color red ] ].

	elem := ToElement new.

	elem background: Color blue.
	space toTheme: theme.
	space root addChild: elem.
	self assert: elem background paint color equals: Color red
]

{ #category : #tests }
ToStyleSheetApplicationTest2 >> testApplicationOnElementHovered [

	| theme elem |
	theme := ToStyleSheetTheme new.
	" default one rule "
	theme addWritableProperty: (ToFeatureProperty name: #background).
	theme select: ToElement asTypeSelector style: [ :sr |
			sr
				when: ToInstallSkinEvent
				write: (theme property: #background)
				with: [ :e | Color red ].
			sr
				when: ToHoveredSkinEvent
				write: (theme property: #background)
				with: [ :e | Color yellow ] ].

	elem := ToElement new.

	elem extent: 20 asPoint.
	elem position: 100 asPoint.
	elem background: Color blue.
	space toTheme: theme.
	space root addChild: elem.
	self waitTestingSpaces.
	self assert: elem background paint color equals: Color red.
	BlSpace simulateMouseMoveInside: elem.
	self waitTestingSpaces.
	self assert: elem background paint color equals: Color yellow
]
