Class {
	#name : #ToThemeTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core-Theme'
}

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
	e addStamp: #'primary'.
	e labelText: 'Default button'.
	self assert: e installedSkin isNil.
	" because of the token properties installation -> have a skin installer/uninstaller "
	self assert: e skinManager skinInstaller notNil.
	"self assert: e skinManager skinUninstaller notNil."
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: e skinManager skinInstaller isNil.
	self assert: e installedSkin notNil.
	"self assert: e skinManager skinUninstaller isNil."
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller isNil.

]
