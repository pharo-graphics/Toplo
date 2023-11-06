"
A ToNullSkinTest is a test class for testing the behavior of ToNullSkin
"
Class {
	#name : 'ToNullSkinTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Tests-Core-Skin',
	#package : 'Toplo-Tests',
	#tag : 'Core-Skin'
}

{ #category : 'tests' }
ToNullSkinTest >> testWithASkinInstalledBefore [

	| w installedSkin nsk |
	w := ToElement new.
	self assert: w skinInstaller isNil.
	self assert: w installedSkin isNil.
	w requestSkin.
	self assert: w skinInstaller notNil.
	w applySkinInstaller.
	installedSkin := w installedSkin.
	self assert: installedSkin notNil.
	self deny: (installedSkin isKindOf: ToNullSkin).
	self assert: w skinStateQueue nextStates notEmpty.
	self assert: w skinStateQueue installed.
	self assert: w skinStateQueue currentStates notEmpty.
	w defaultSkin: (nsk := ToNullSkin new).
	w applySkinInstaller.
	self deny: w installedSkin identicalTo: installedSkin.
	self assert: w installedSkin identicalTo: nsk.
	w applySkinInstaller.
	self assert: w installedSkin identicalTo: nsk.
	w requestSkin.
	w applySkinInstaller.
	w flushSkinStates.
	self assert: w installedSkin identicalTo: nsk.
	self assert: w skinStateQueue nextStates isEmpty.
	self assert: w skinStateQueue currentStates size equals: 1.
	self deny: w skinStateQueue installed.

]

{ #category : 'tests' }
ToNullSkinTest >> testWithoutSkin [

	| w sk |
	w := ToElement new.
	w withoutSkin.
	self assert: w skinInstaller notNil.
	w applySkinInstaller.
	self assert: w installedSkin isNullSkin.

	self assert: ((sk := w installedSkin) isKindOf: ToNullSkin).
	w requestSkin.
	w applySkinInstaller.
	self assert: w installedSkin identicalTo: sk.
	self assert: w skinStateQueue nextStates isEmpty.
	self assert: w skinStateQueue currentStates isEmpty.
	self deny: w skinStateQueue installed.

]
