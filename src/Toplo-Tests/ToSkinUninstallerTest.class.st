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
	e skinManager setSkinUninstaller: ToSkinUninstaller new in: e.
	e skinManager applySkinUninstallerIn: e.
	self deny: e skinManager installedSkin notNil.
	space root addChild: e.
	e skinManager applySkinReinstallIn: e.
	self assert: e skinManager installedSkin notNil.
	e skinManager setSkinUninstaller: ToSkinUninstaller new in: e.
	e skinManager applySkinUninstallerIn: e.
	self assert: e skinManager installedSkin isNil
]

{ #category : #tests }
ToSkinUninstallerTest >> testApplyOnWithRawSkin [

	| e |
	e := ToElementForRawSkinTest new.
	space toTheme: ToRawTheme new.
	e skinManager setSkinUninstaller: ToSkinUninstaller new in: e.
	e skinManager applySkinUninstallerIn: e.
	self deny: e skinManager installedSkin notNil.
	" since the element is not attached "
	self deny: e styleUninstalled.
	space root addChild: e.
	e skinManager applySkinReinstallIn: e.
	self assert: e skinManager installedSkin notNil.
	self assert: e styleInstalled.
	e skinManager setSkinUninstaller: ToSkinUninstaller new in: e.
	e skinManager applySkinUninstallerIn: e.
	self assert: e skinManager installedSkin isNil.
	self assert: e styleUninstalled
]

{ #category : #tests }
ToSkinUninstallerTest >> testWithNullSkin [

	| e |
	e := ToElement new.
	space root addChild: e.
	self assert: e skinManager skinInstaller notNil.
	e skinManager applySkinReinstallIn: e.
	self assert: e skinManager installedSkin notNil.
	e withNullSkin.
	e skinManager applySkinUninstallerIn: e.
	self assert: e skinManager installedSkin isNil.
	self assert: e skinManager skinInstaller notNil.
	e skinManager applySkinReinstallIn: e.
	self assert: e skinManager installedSkin isNullSkin
]

{ #category : #tests }
ToSkinUninstallerTest >> testWithSetSkin [

	| e |
	e := ToElement new.
	space root addChild: e.
	self assert: e skinManager skinInstaller notNil.
	e skinManager applySkinReinstallIn: e.
	self assert: e skinManager installedSkin notNil.
	e defaultSkin: ToNullSkin new.
	e skinManager applySkinUninstallerIn: e.
	self assert: e skinManager installedSkin isNil.
	self assert: e skinManager skinInstaller notNil.
	e skinManager applySkinReinstallIn: e.
	self assert: e skinManager installedSkin isNullSkin
]
