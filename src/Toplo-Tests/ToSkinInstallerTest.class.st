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
	" an element with no local theme must be attached to a space 
	because installing a skin requires a theme"
	self should: [ e applySkinInstaller ] raise: Error.
	self assert: e skinInstaller isNil.
	space root addChild: e.
	e applySkinInstaller.
	self assert: e installedSkin notNil
]

{ #category : 'tests' }
ToSkinInstallerTest >> testApplyOn2 [

	| e |
	e := ToElement new.
	self assert: e skinInstaller isNil.
	e skinInstaller: ToSkinInstaller new.
	e localToTheme: ToRawTheme new.
	e applySkinInstaller.
	self assert: e skinInstaller isNil.
	self assert: e installedSkin notNil
]

{ #category : 'tests' }
ToSkinInstallerTest >> testInstallSkinIn [

	| e |
	e := ToElement new.
	self assert: e skinInstaller isNil.
	self assert: e installedSkin isNil.
	e skinInstaller: ToSkinInstaller new.
	self assert: e skinInstaller notNil.
	self assert: e installedSkin isNil.
	" if not theme is found in its parent chain, then an element must be attached to a space. 
	If not, skin installation raises an Error because during skin installation the element theme is lookup "
	space root addChild: e.
	e skinInstaller applyOn: e.
	self assert: e skinInstaller isNil.
	self assert: e installedSkin notNil.
	self
		assert: e installedSkin class
		equals: (e toTheme newSkinFor: e) class
]

{ #category : 'tests' }
ToSkinInstallerTest >> testInstallSkinIn2 [

	| e myTheme |
	e := ToElement new.
	self assert: e skinInstaller isNil.
	self assert: e installedSkin isNil.
	e skinInstaller: ToSkinInstaller new.
	self assert: e skinInstaller notNil.
	self assert: e installedSkin isNil.
	" if not theme is found in its parent chain, then an element must be attached to a space. 
	If not, skin installation raises an Error because during skin installation the element theme is lookup "
	e localToTheme: (myTheme := ToRawTheme new).
	self assert: e toTheme identicalTo: myTheme.
	e skinInstaller applyOn: e.
	self assert: e skinInstaller isNil.
	self assert: e installedSkin notNil.
	self
		assert: e installedSkin class
		equals: (myTheme newSkinFor: e) class
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
