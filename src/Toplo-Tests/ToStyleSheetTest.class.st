"
A ToStyleSheetTest is a test class for testing the behavior of ToStyleSheet
"
Class {
	#name : #ToStyleSheetTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-StyleSheet'
}

{ #category : #tests }
ToStyleSheetTest >> testDefaultStyleScript [

	| sheet defaultScript |
	sheet := ToStyleSheet new.
	defaultScript := sheet defaultScript.
	self assert: sheet script class identicalTo: defaultScript class.
	self assert: sheet script styleRules size equals: defaultScript styleRules size
]

{ #category : #tests }
ToStyleSheetTest >> testInherits [

	| sheet |
	sheet := ToStyleSheet new.
	self assert: sheet inherits.
	sheet inherits: false.
	self deny: sheet inherits
]

{ #category : #tests }
ToStyleSheetTest >> testInitialize [

	| sheet |
	sheet := ToStyleSheet new.
	self assert: sheet styleRules notNil.
	self assert: sheet styleRules size equals: sheet defaultScript styleRules size.
	self assert: sheet inherits.
]

{ #category : #'writable property tests' }
ToStyleSheetTest >> testMyOutskirts [

	| e styleSheet theme writers |
	styleSheet := ToStyleSheet new
		              inherits: false;
		              yourself.

	theme := ToStyleSheetTheme new.

	styleSheet addWritableProperty: (ToPseudoProperty
			   name: #myOutskirts
			   reader: [ :elem | elem outskirts ]
			   writer: [ :elem :v | elem outskirts: v ]).
	styleSheet select: styleSheet any style: [ :sr |
		sr write: (styleSheet property: #myOutskirts) with: BlOutskirts centered].

	e := ToElement new.
	e outskirts: BlOutskirts inside.
	e localTheme: theme.
	e styleSheet: styleSheet.
	space root addChild: e.
	space applyAllSkinPhases.

	writers := theme applicableWritersFor: e.
	self assert: writers size equals: 1.
	self assert: e outskirts equals: BlOutskirts centered
]

{ #category : #tests }
ToStyleSheetTest >> testOnInstalledIn [

	| sheet e child |
	sheet := ToStyleSheet new.
	e := ToElement new.
	child := ToElement new.
	e addChild: child.
	space root addChild: e.
	space applyAllSkinInstallers.
	self deny: e skinManager newSkinRequested.
	self assert: e skinManager installedSkin isKnownSkin.
	self deny: child skinManager newSkinRequested.
	self assert: child skinManager installedSkin isKnownSkin.
	e styleSheet: sheet.
	self assert: e skinManager newSkinRequested.
	self assert: child skinManager newSkinRequested.

]

{ #category : #tests }
ToStyleSheetTest >> testOnUninstalledIn [

	| sheet e child |
	sheet := ToStyleSheet new.
	e := ToElement new.
	child := ToElement new.
	e addChild: child.
	space root addChild: e.
	e styleSheet: sheet.
	space applyAllSkinInstallers.
	self deny: e skinManager newSkinRequested.
	self deny: child skinManager newSkinRequested.
	e styleSheet: nil.
	self assert: e skinManager newSkinRequested.
	self deny: child skinManager newSkinRequested
]

{ #category : #'writable property tests' }
ToStyleSheetTest >> testOutskirts [

	| e styleSheet theme writers |
	styleSheet := ToStyleSheet new
		              inherits: false;
		              yourself.

	theme := ToStyleSheetTheme new.

	styleSheet select: styleSheet any style: [ :sr |
		sr write: (styleSheet property: #outskirts) with: BlOutskirts centered].

	e := ToElement new.
	e outskirts: BlOutskirts inside.
	e localTheme: theme.
	e styleSheet: styleSheet.
	space root addChild: e.
	space applyAllSkinPhases.

	writers := theme applicableWritersFor: e.
	self assert: writers size equals: 1.
	self assert: e outskirts equals: BlOutskirts centered
]
