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
	e toThemeManager applySkinUninstallerIn: e.
	space root addChild: e.
	e applySkinInstaller.
	self assert: e installedSkin notNil.
	e skinUninstaller: ToSkinUninstaller new.
	e toThemeManager applySkinUninstallerIn: e.
	self assert: e installedSkin isNil.


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
	e toThemeManager applySkinUninstallerIn: e.
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
	e toThemeManager applySkinUninstallerIn: e.
	self assert: e installedSkin isNil.
	self assert: e skinInstaller notNil.
	e applySkinInstaller.
	self assert: e installedSkin isNullSkin.


]
