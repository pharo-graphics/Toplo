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
	space root addChild: e.
	self waitTestingSpaces.
	self assert: e skinManager skinInstaller isNil.
	space toTheme: ToRawDarkTheme new.
	self waitTestingSpaces.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller isNil.
	self assert: e skinManager installedSkin class identicalTo: ToRawSkinForThemeTest
]

{ #category : #tests }
ToThemeTest >> testThemeChangedWithStyleSheetTheme [

	| e |
	e := ToElement new.
	e defaultRawSkin: ToRawSkinForThemeTest new.
	space root addChild: e.
	self waitTestingSpaces.
	self assert: e skinManager skinInstaller isNil.
	self assert: (e skinManager installedSkin isKindOf: ToRawSkinForThemeTest).
	space toTheme: ToBeeDarkTheme new.
	self waitTestingSpaces.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller isNil.
	self assert: (e skinManager installedSkin isKindOf: ToBeeSkin)
]

{ #category : #tests }
ToThemeTest >> testThemeChangedWithStyleSheetTheme2 [

	| e |
	e := ToButton new.
	space root addChild: e.
	e addStamp: #'primary'.
	e labelText: 'Default button'.
	self waitTestingSpaces.
	space toTheme: ToBeeDarkTheme new.
	self waitTestingSpaces.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller isNil.
	self assert: (e skinManager installedSkin isKindOf: ToBeeSkin)

]

{ #category : #tests }
ToThemeTest >> testThemeChangedWithStyleSheetTheme3 [

	| e |
	e := ToLabeledIcon new.
	space toTheme: ToBeeDarkTheme new.
	space root addChild: e.
	e addStamp: #primary.
	e labelText: 'Default button'.
	self assert: e skinManager installedSkin isKnownSkin.
	" because of the token properties installation -> have a skin installer/uninstaller "
	self assert: e skinManager skinInstaller notNil.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: e skinManager skinInstaller isNil.
	self assert: e skinManager installedSkin isKnownSkin.
	"self assert: e skinManager skinUninstaller isNil."
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller isNil
]
