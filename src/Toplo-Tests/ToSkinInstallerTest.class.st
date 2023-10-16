"
A ToLazySkintInstallerTest is a test class for testing the behavior of ToLazySkintInstaller
"
Class {
	#name : 'ToSkinInstallerTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Tests-Core-Skin',
	#package : 'Toplo-Tests',
	#tag : 'Core-Skin'
}

{ #category : 'tests' }
ToSkinInstallerTest >> testApplyOn [

	| space e s |
	space := BlSpace new.
	space stopSkinInstallerPhase.
	e := ToElement new removeSkinInstallerPhaseChecker.
	space root addChild: e.
	self assert: e skinInstaller notNil.
	self assert: (e skinInstaller isKindOf: ToSkinInstaller).
	e defaultSkin: (s := ToRawSkin new).
	e applySkinInstaller.
	" the default skin is installed "
	self assert: e installedSkin identicalTo: s.
	" the installer has been removed "
	self assert: e skinInstaller isNil.
	" the element state is initial "
	self assert: e currentSkinState class identicalTo: ToInitialState
]
