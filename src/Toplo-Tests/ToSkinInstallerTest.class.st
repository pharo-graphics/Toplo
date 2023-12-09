Class {
	#name : 'ToSkinInstallerTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-Theme',
	#package : 'Toplo-Tests',
	#tag : 'Core-Theme'
}

{ #category : 'running' }
ToSkinInstallerTest >> setUp [ 
	super setUp.
	space := self newTestingSpace
]

{ #category : 'tests' }
ToSkinInstallerTest >> testApplyOn [

	| e |
	e := ToElement new.
	e skinInstaller: ToSkinInstaller new.
	" an element must be attached to a space 
	because installing a skin requires a theme"
	self should: [ e applySkinInstaller ] raise: Error.
	self assert: e skinInstaller notNil.
	space root addChild: e.
	e applySkinInstaller.
	self assert: e installedSkin notNil
]

{ #category : 'tests' }
ToSkinInstallerTest >> testInstallSkinInWithErrorNonAttachedInSpace [

	| e |
	e := ToElement new.
	self assert: e skinInstaller isNil.
	self assert: e installedSkin isNil.
	e skinInstaller: ToSkinInstaller new.
	self assert: e skinInstaller notNil.
	self assert: e installedSkin isNil.
	self should: [ e skinInstaller applyOn: e ] raise: Error
]
