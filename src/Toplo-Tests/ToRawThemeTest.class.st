"
A ToRawThemeTest is a test class for testing the behavior of ToRawTheme
"
Class {
	#name : #ToRawThemeTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #tests }
ToRawThemeTest >> testName [
	| theme |
	theme := ToRawTheme new.
	theme name
]

{ #category : #tests }
ToRawThemeTest >> testNewRootSkinInstance [

	| space e theme |
	theme := ToRawTheme new.
	space := BlSpace new.
	e := space root.
	self assert: ((theme newSkinInstanceFor: e) isKindOf: ToRawSkin).
	self assert: (theme newSkinInstanceFor: e) class identicalTo: theme newRootSkinInstance class
]

{ #category : #tests }
ToRawThemeTest >> testNewSkinInstanceFor [

	| e |
	e := BlElement new.
	self assert: ((ToRawTheme new newSkinInstanceFor: e) isKindOf: ToRawSkin).
	self assert: (ToRawTheme new newSkinInstanceFor: e) class identicalTo: e newRawSkin class
]
