Class {
	#name : #ToThemeTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #tests }
ToThemeTest >> testThemeChanged [

	| e |
	e := ToElement new.
	e defaultSkin: ToRawSkinForThemeTest new.
	space deferAndSettle: [ space root addChild: e ].
	self deny: e skinManager newSkinRequested.

	space deferAndSettle: [ space toTheme: ToRawDarkTheme new ].
	self deny: e skinManager newSkinRequested.
	self assert: e skinManager installedSkin class identicalTo: ToRawSkinForThemeTest
]

{ #category : #tests }
ToThemeTest >> testThemeChangedWithStyleSheetTheme [

	| e |
	e := ToElement new.
	e defaultSkin: ToRawSkinForThemeTest new.
	space deferAndSettle: [ space root addChild: e ].
	self deny: e skinManager newSkinRequested.
	self assert: (e skinManager installedSkin isKindOf: ToRawSkinForThemeTest).

	space deferAndSettle: [ space toTheme: ToBeeDarkTheme new ].
	self deny: e skinManager newSkinRequested.
	self deny: (e skinManager installedSkin isKindOf: ToBeeSkin).
	self assert: e skinManager installedSkin identicalTo: e defaultSkin
]

{ #category : #tests }
ToThemeTest >> testThemeChangedWithStyleSheetTheme2 [

	| e |
	e := ToButton new.
	space deferAndSettle: [
		space root addChild: e.
		e addStamp: #'primary'.
		e labelText: 'Default button' .
		space toTheme: ToBeeDarkTheme new ].
	self deny: e skinManager newSkinRequested.
	self assert: (e skinManager installedSkin isKindOf: ToBeeSkin)
]

{ #category : #tests }
ToThemeTest >> testThemeChangedWithStyleSheetTheme3 [

	| e |
	e := ToLabeledIcon new.
	space deferAndSettle: [
		space toTheme: ToBeeDarkTheme new.
		space root addChild: e.
		e addStamp: #primary.
		e labelText: 'Default button' ].
	self assert: e skinManager installedSkin isThemeSkin.
	self deny: e skinManager newSkinRequested.
	self assert: e skinManager installedSkin isThemeSkin.
	self deny: e skinManager newSkinRequested
]
