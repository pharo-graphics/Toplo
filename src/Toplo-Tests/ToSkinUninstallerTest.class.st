"
A ToSkinUninstallerTest is a test class for testing the behavior of ToSkinUninstaller
"
Class {
	#name : 'ToSkinUninstallerTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-Theme',
	#package : 'Toplo-Tests',
	#tag : 'Core-Theme'
}

{ #category : 'running' }
ToSkinUninstallerTest >> setUp [ 
	super setUp.
	space := self newTestingSpace
]

{ #category : 'tests' }
ToSkinUninstallerTest >> testApplyOn [

	| e |
	e := ToElement new.
	e skinUninstaller: ToSkinUninstaller new.
	e skinManager applySkinUninstallerIn: e.
	self deny: e installedSkin notNil.
	space root addChild: e.
	e applySkinInstaller.
	self assert: e installedSkin notNil.
	e skinUninstaller: ToSkinUninstaller new.
	e skinManager applySkinUninstallerIn: e.
	self assert: e installedSkin isNil.


]

{ #category : 'tests' }
ToSkinUninstallerTest >> testApplyOnWithRawSkin [ 

	| e |
	e := ToElementForRawSkinTest new.
	space toTheme: ToRawTheme light.
	e skinUninstaller: ToSkinUninstaller new.
	e skinManager applySkinUninstallerIn: e.
	self deny: e installedSkin notNil.
	" since the element is not attached "
	self deny: e styleUninstalled.
	space root addChild: e.
	e applySkinInstaller.
	self assert: e installedSkin notNil.
	self assert: e styleInstalled.
	e skinUninstaller: ToSkinUninstaller new.
	e skinManager applySkinUninstallerIn: e.
	self assert: e installedSkin isNil.
	self assert: e styleUninstalled.



]

{ #category : 'tests' }
ToSkinUninstallerTest >> testWithSetSkin [

	| e |
	e := ToElement new.
	space root addChild: e.
	self assert: e skinInstaller notNil.
	e applySkinInstaller.
	self assert: e installedSkin notNil.
	e setSkin: ToNullSkin new.
	e skinManager applySkinUninstallerIn: e.
	self assert: e installedSkin isNil.
	self assert: e skinInstaller notNil.
	e applySkinInstaller.
	self assert: e installedSkin isNullSkin.


]

{ #category : 'tests' }
ToSkinUninstallerTest >> testWithoutSkin [

	| e |
	e := ToElement new.
	space root addChild: e.
	self assert: e skinInstaller notNil.
	e applySkinInstaller.
	self assert: e installedSkin notNil.
	e withoutSkin.
	e skinManager applySkinUninstallerIn: e.
	self assert: e installedSkin isNil.
	self assert: e skinInstaller notNil.
	e applySkinInstaller.
	self assert: e installedSkin isNullSkin.


]
