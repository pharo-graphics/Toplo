"
A ToRawThemeTest is a test class for testing the behavior of ToRawTheme
"
Class {
	#name : 'ToRawThemeTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Tests-Core-Theme',
	#package : 'Toplo-Tests',
	#tag : 'Core-Theme'
}

{ #category : 'tests' }
ToRawThemeTest >> testName [
	| theme |
	theme := ToRawTheme light.
	theme name
]

{ #category : 'tests' }
ToRawThemeTest >> testNewRootSkinInstance [

	| space e theme |
	theme := ToRawTheme light.
	space := BlSpace new.
	e := space root.
	self assert: ((theme newSkinInstanceFor: e) isKindOf: ToRawSkin).
	self assert: (theme newSkinInstanceFor: e) class identicalTo: theme newRootSkinInstance class
]

{ #category : 'tests' }
ToRawThemeTest >> testNewSkinInstanceFor [

	| e |
	e := BlElement new.
	self assert: ((ToRawTheme light newSkinInstanceFor: e) isKindOf: ToRawSkin).
	self assert: (ToRawTheme light newSkinInstanceFor: e) class identicalTo: e newRawSkin class
]
