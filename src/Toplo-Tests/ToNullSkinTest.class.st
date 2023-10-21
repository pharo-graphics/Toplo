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
	w defaultSkin: (nsk := ToNullSkin new).
	w requestSkin.
	self assert: w installedSkin identicalTo: installedSkin.
	w applySkinInstaller.
	self deny: w installedSkin identicalTo: installedSkin.
	self assert: w installedSkin identicalTo: nsk.
	w requestSkin.
	w applySkinInstaller.
	self assert: w installedSkin identicalTo: nsk
]

{ #category : 'tests' }
ToNullSkinTest >> testWithoutSkin [

	| w sk |
	w := ToElement new.
	w withoutSkin.
	self assert: w skinInstaller notNil.
	self assert: w installedSkin isNil.
	w applySkinInstaller.
	self assert: ((sk := w installedSkin) isKindOf: ToNullSkin).
	w requestSkin.
	w applySkinInstaller.
	self assert: w installedSkin identicalTo: sk
]
