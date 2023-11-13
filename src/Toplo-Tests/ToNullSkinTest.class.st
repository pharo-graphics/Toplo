"
A ToNullSkinTest is a test class for testing the behavior of ToNullSkin
"
Class {
	#name : 'ToNullSkinTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Tests-Core-Theme',
	#package : 'Toplo-Tests',
	#tag : 'Core-Theme'
}

{ #category : 'tests' }
ToNullSkinTest >> testWithASkinInstalledBefore [

	| w installedSkin nsk |
	w := ToElement new.
	self assert: w skinInstaller isNil.
	self assert: w installedSkin isNil.
	w requestSkin.
	BlSpace new root addChild: w.
	self assert: w skinInstaller notNil.
	w applySkinInstaller.
	installedSkin := w installedSkin.
	self assert: installedSkin notNil.
	self deny: (installedSkin isKindOf: ToNullSkin).
	self deny: w skinStateQueue nextStates isEmpty.
	w defaultSkin: (nsk := ToNullSkin new).
	w applySkinInstaller.
	self deny: w installedSkin identicalTo: installedSkin.
	self assert: w installedSkin identicalTo: nsk.
	w applySkinInstaller.
	self assert: w installedSkin identicalTo: nsk.
	w requestSkin.
	w applySkinInstaller.
	w updateStyles.
	self assert: w installedSkin identicalTo: nsk.
	self assert: w skinStateQueue nextStates isEmpty.
	w enqueueSkinState: (ToTransientState lookEvent:  ToHoveredLookEvent new).
	w updateStyles.
	self assert: w skinStateQueue nextStates size identicalTo: 1
]

{ #category : 'tests' }
ToNullSkinTest >> testWithoutSkin [

	| w sk |
	w := ToElement new.
	w withoutSkin.
	BlSpace new root addChild: w.
	self assert: w skinInstaller notNil.
	w applySkinInstaller.
	self assert: w installedSkin isNullSkin.

	self assert: ((sk := w installedSkin) isKindOf: ToNullSkin).
	w requestSkin.
	w applySkinInstaller.
	self assert: w installedSkin identicalTo: sk.
	self assert: w skinStateQueue nextStates isEmpty
]
