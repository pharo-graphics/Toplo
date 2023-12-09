"
A ToStyleSheetTest is a test class for testing the behavior of ToStyleSheet
"
Class {
	#name : 'ToStyleSheetTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-StyleSheet',
	#package : 'Toplo-Tests',
	#tag : 'Core-StyleSheet'
}

{ #category : 'running' }
ToStyleSheetTest >> setUp [

	super setUp.
	space := self newTestingSpace.

]

{ #category : 'tests' }
ToStyleSheetTest >> testInitialize [

	| sheet |
	sheet := ToStyleSheet new.
	self assert: sheet styleRules notNil.
	self assert: sheet styleRules size equals: sheet defaultStyleRules size.
	self assert: sheet inherits.
]

{ #category : 'tests' }
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
