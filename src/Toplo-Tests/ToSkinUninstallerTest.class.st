"
A ToSkinUninstallerTest is a test class for testing the behavior of ToSkinUninstaller
"
Class {
	#name : #ToSkinUninstallerTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #tests }
ToSkinUninstallerTest >> testApplyOn [

	| e |
	e := ToElement new.
	e skinManager forceSkinUninstaller: ToSkinUninstaller new in: e.
	e skinManager applySkinUninstallerIn: e.
	self deny: e skinManager installedSkin isKnownSkin.
	space root addChild: e.
	e skinManager applySkinReinstallIn: e.
	self assert: e skinManager installedSkin isKnownSkin.
	e skinManager forceSkinUninstaller: ToSkinUninstaller new in: e.
	e skinManager applySkinUninstallerIn: e.
	self deny: e skinManager installedSkin isKnownSkin
]

{ #category : #tests }
ToSkinUninstallerTest >> testApplyOnWithRawSkin [

	| e |
	e := ToElementForRawSkinTest new.
	space toTheme: ToRawTheme new.
	e skinManager forceSkinUninstaller: ToSkinUninstaller new in: e.
	e skinManager applySkinUninstallerIn: e.
	self deny: e skinManager installedSkin isKnownSkin.
	" since the element is not attached "
	self deny: e styleUninstalled.
	space root addChild: e.
	e skinManager applySkinReinstallIn: e.
	self assert: e skinManager installedSkin isKnownSkin.
	self assert: e styleInstalled.
	e skinManager forceSkinUninstaller: ToSkinUninstaller new in: e.
	e skinManager applySkinUninstallerIn: e.
	self deny: e skinManager installedSkin isKnownSkin.
	self assert: e styleUninstalled
]

{ #category : #tests }
ToSkinUninstallerTest >> testWithNullSkin [

	| e |
	e := ToElement new.
	space root addChild: e.
	self assert: e skinManager skinInstaller isNil.
	e skinManager applySkinReinstallIn: e.
	self assert: e skinManager installedSkin isKnownSkin.
	e withNullSkin.
	e skinManager applySkinUninstallerIn: e.
	self deny: e skinManager installedSkin isKnownSkin.
	self assert: e skinManager skinInstaller notNil.
	e skinManager applySkinReinstallIn: e.
	self assert: e skinManager installedSkin isNullSkin
]

{ #category : #tests }
ToSkinUninstallerTest >> testWithSetSkin [

	| e |
	e := ToElement new.
	space root addChild: e.
	self assert: e skinManager skinInstaller isNil.
	e skinManager applySkinReinstallIn: e.
	self assert: e skinManager installedSkin isKnownSkin.
	e defaultSkin: ToNullSkin new.
	e skinManager applySkinUninstallerIn: e.
	self deny: e skinManager installedSkin isKnownSkin.
	self assert: e skinManager skinInstaller notNil.
	e skinManager applySkinReinstallIn: e.
	self assert: e skinManager installedSkin isNullSkin
]
