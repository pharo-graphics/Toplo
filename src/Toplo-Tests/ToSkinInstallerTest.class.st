Class {
	#name : #ToSkinInstallerTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #tests }
ToSkinInstallerTest >> testApplyOn [

	| e |
	e := ToElement new.
	self
		should: [ e skinManager forceSkinInstaller: ToSkinInstaller new in: e ]
		raise: Error.
	" an element must be attached to a space 
	because installing a skin requires a theme"
	self should: [ e skinManager applySkinReinstallIn: e ] raise: Error.
	self assert: e skinManager skinInstaller notNil.
	space root addChild: e.
	e skinManager applySkinReinstallIn: e.
	self assert: e skinManager installedSkin notNil
]

{ #category : #tests }
ToSkinInstallerTest >> testApplyOnWithRawSkin [

	| e |
	e := ToElementForRawSkinTest new.
	space toTheme: ToRawTheme new.
	self
		should: [ e skinManager forceSkinInstaller: ToSkinInstaller new in: e ]
		raise: Error.
	" an element must be attached to a space 
	because installing a skin requires a theme"
	self should: [ e skinManager applySkinReinstallIn: e ] raise: Error.
	self deny: e styleInstalled.
	self assert: e skinManager skinInstaller notNil.
	space root addChild: e.
	e skinManager applySkinReinstallIn: e.
	self assert: e skinManager installedSkin notNil.
	self assert: e styleInstalled
]

{ #category : #tests }
ToSkinInstallerTest >> testInstallSkinInWithErrorNonAttachedInSpace [

	| e |
	e := ToElement new.
	self assert: e skinManager skinInstaller isNil.
	self assert: e skinManager installedSkin isNil.
	self
		should: [ e skinManager forceSkinInstaller: ToSkinInstaller new in: e ]
		raise: Error.
	self assert: e skinManager skinInstaller notNil.
	self assert: e skinManager installedSkin isNil.
	" an element must be attached to a space 
	because installing a skin requires a theme"
	self should: [ e lookupTheme ] raise: Error.
	self should: [ e skinManager skinInstaller applyOn: e ] raise: Error
]
