Class {
	#name : #ToThemeTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #tests }
ToThemeTest >> testEqual [

	| theme1 theme2 theme3 theme4 |
	theme1 := ToRawTheme light.
	theme2 := ToRawTheme light.
	theme3 := ToRawTheme dark.
	theme4 := ToRawTheme dark.
	self assert: theme1 = theme1.
	self assert: theme1 = theme2.
	self assert: theme3 = theme3.
	self assert: theme3 = theme4.
	self deny: theme1 = theme3.
	self deny: theme4 = theme2.
]

{ #category : #tests }
ToThemeTest >> testHash [

	| theme1 theme2 theme3 theme4 |
	theme1 := ToRawTheme light.
	theme2 := ToRawTheme light.
	theme3 := ToRawTheme dark.
	theme4 := ToRawTheme dark.
	self assert: { theme1 . theme3 } asSet size equals: 2.
	self assert: { theme1 . theme2 } asSet size equals: 1.
	self assert: { theme2 . theme4 } asSet size equals: 2.
	self assert: { theme3 . theme4 } asSet size equals: 1.
	self assert: { theme1 . theme2 . theme3 . theme4 } asSet size equals: 2.
	self assert: ({ theme1 . theme2 . theme3 . theme4 } asSet includes: ToRawTheme light).
	self assert: ({ theme1 . theme2 . theme3 . theme4 } asSet includes: ToRawTheme dark).
]

{ #category : #tests }
ToThemeTest >> testThemeChanged [

	| e |
	e := ToElementForThemeTest new.
	e defaultSkin: ToRawSkinForThemeTest new.
	space root addChild: e.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: e skinManager skinInstaller isNil.
	space toTheme: ToRawTheme dark.
	self assert: e skinManager skinUninstaller notNil.
	self assert: e skinManager skinInstaller notNil.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller isNil.

]

{ #category : #tests }
ToThemeTest >> testThemeChangedWithStyleSheetTheme [

	| e |
	e := ToElementForThemeTest new.
	e defaultSkin: ToRawSkinForThemeTest new.
	space root addChild: e.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: e skinManager skinInstaller isNil.
	space toTheme: ToBeeTheme dark.
	self assert: e skinManager skinUninstaller notNil.
	self assert: e skinManager skinInstaller notNil.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller isNil.

]

{ #category : #tests }
ToThemeTest >> testThemeChangedWithStyleSheetTheme2 [

	| e |
	e := ToButton new.
	space root addChild: e.
	e addStamp: #'primary'.
	e labelText: 'Default button'.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	space toTheme: ToBeeTheme dark.
	self assert: e skinManager skinInstaller notNil.
	self assert: e skinManager skinUninstaller notNil.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller isNil.

]

{ #category : #tests }
ToThemeTest >> testThemeChangedWithStyleSheetTheme3 [

	| e |
	e := ToLabeledIcon new.
	e applySkinInstallerOnFirstRequest: false.
	space toTheme: ToBeeTheme dark.
	space root addChild: e.
	e addStamp: #primary.
	e labelText: 'Default button'.
	self assert:
		(e skinManager installedSkin) isNil.
	" because of the token properties installation -> have a skin installer/uninstaller "
	self assert: e skinManager skinInstaller notNil.
	"self assert: e skinManager skinUninstaller notNil."
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: e skinManager skinInstaller isNil.
	self assert:
		(e skinManager installedSkin) notNil.
	"self assert: e skinManager skinUninstaller isNil."
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller isNil
]
