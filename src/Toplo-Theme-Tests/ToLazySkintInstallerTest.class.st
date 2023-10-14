"
A ToLazySkintInstallerTest is a test class for testing the behavior of ToLazySkintInstaller
"
Class {
	#name : 'ToLazySkintInstallerTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Theme-Tests-Core',
	#package : 'Toplo-Theme-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
ToLazySkintInstallerTest >> testApplyOn [

	| space e s |
	space := BlSpace new.
	space stopSkinInstallerPhase.
	e := ToElement new removeSkinInstallerPhaseChecker.
	space root addChild: e.
	self assert: e skinInstaller notNil.
	self assert: (e skinInstaller isKindOf: ToLazySkintInstaller).
	e defaultSkin: (s := ToRawSkin new).
	e applySkinInstaller.
	" the default skin is installed "
	self assert: e privateSkin identicalTo: s.
	" the installer has been removed "
	self assert: e skinInstaller isNil.
	" the element state is initial "
	self assert: e currentSkinState class identicalTo: ToInitialState
]
