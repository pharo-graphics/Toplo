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
	space deferAndSettle: [ space root addChild: e ].

	writers := theme applicableWritersFor: e.
	self assert: writers size equals: 1.
	self assert: e outskirts equals: BlOutskirts centered
]

{ #category : #tests }
ToStyleSheetTest >> testOnInstalledIn [

	| sheet e child requested childRequested |
	sheet := ToStyleSheet new.
	e := ToElement new.
	child := ToElement new.
	e addChild: child.
	space deferAndSettle: [ space root addChild: e ].
	self deny: e skinManager newSkinRequested.
	self assert: e skinManager installedSkin isThemeSkin.
	self deny: child skinManager newSkinRequested.
	self assert: child skinManager installedSkin isThemeSkin.

	space deferAndSettle: [
		e styleSheet: sheet.
		requested := e skinManager newSkinRequested.
		childRequested := child skinManager newSkinRequested ].
		
	self assert: requested.
	self assert: childRequested
]

{ #category : #tests }
ToStyleSheetTest >> testOnUninstalledIn [

	| sheet e child requested childRequested |
	sheet := ToStyleSheet new.
	e := ToElement new.
	child := ToElement new.
	e addChild: child.
	space deferAndSettle: [
		space root addChild: e.
		e styleSheet: sheet ].
	self deny: e skinManager newSkinRequested.
	self deny: child skinManager newSkinRequested.

	space deferAndSettle: [
		e styleSheet: nil.
		requested := e skinManager newSkinRequested.
		childRequested := child skinManager newSkinRequested ].
		
	self assert: requested.
	self deny: childRequested
]

{ #category : #'writable property tests' }
ToStyleSheetTest >> testOutskirts [

	| e styleSheet theme writers |
	styleSheet := ToStyleSheet new
		              inherits: false;
		              yourself.

	styleSheet addWritableProperty: (ToFeatureProperty name: #outskirts).
	theme := ToStyleSheetTheme new.

	styleSheet select: styleSheet any style: [ :sr |
		sr write: (styleSheet property: #outskirts) with: BlOutskirts centered].

	e := ToElement new.
	e outskirts: BlOutskirts inside.
	e localTheme: theme.
	e styleSheet: styleSheet.
	space deferAndSettle: [ space root addChild: e ].

	writers := theme applicableWritersFor: e.
	self assert: writers size equals: 1.
	self assert: e outskirts equals: BlOutskirts centered
]
