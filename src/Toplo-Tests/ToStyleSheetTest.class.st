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

{ #category : #tests }
ToStyleSheetTest >> testOnInstalledIn [

	| sheet e child |
	sheet := ToStyleSheet new.
	e := ToElement new.
	child := ToElement new.
	e addChild: child.
	space root addChild: e.
	space applyAllSkinInstallers.
	self assert: e skinManager skinInstaller isNil.
	self assert: e skinManager installedSkin notNil.
	self assert: child skinManager skinInstaller isNil.
	self assert: child skinManager installedSkin notNil.
	e styleSheet: sheet.
	self assert: e skinManager skinInstaller notNil.
	self assert: child skinManager skinInstaller notNil.
	self assert: e skinManager skinUninstaller notNil.
	self assert: child skinManager skinUninstaller notNil.

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
	self deny: e skinManager skinInstaller notNil.
	self deny: child skinManager skinInstaller notNil.
	self deny: e skinManager skinUninstaller notNil.
	self deny: child skinManager skinUninstaller notNil.
	e styleSheet: nil.
	self assert: e skinManager skinInstaller isNil.
	self assert: child skinManager skinInstaller isNil.
	self assert: e skinManager skinUninstaller notNil.
	self assert: child skinManager skinUninstaller notNil.

]
