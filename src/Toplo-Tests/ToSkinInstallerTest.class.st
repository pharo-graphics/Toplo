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
		should: [ e skinManager forceNewSkinRequested: true in:  e ]
		raise: Error.
	" an element must be attached to a space 
	because installing a skin requires a theme"
	self should: [ e skinManager installNewSkinIn: e ] raise: Error.
	self assert: e skinManager newSkinRequested.
	" need to reset the skin to the initial (unknown skin) because 
	the previous error let the skinManager in an invalid state"
	e skinManager uninstallSkinIn: e.
	space root addChild: e.
	e skinManager installNewSkinIn: e.
	self assert: e skinManager installedSkin isThemeSkin
]

{ #category : #tests }
ToSkinInstallerTest >> testApplyOnWithRawSkin [

	| e |
	e := ToElementForRawSkinTest new.
	space toTheme: ToRawTheme new.
	self
		should: [ e skinManager forceNewSkinRequested: true in: e ]
		raise: ToSpaceNotFoundError.
	" an element must be attached to a space 
	because installing a skin requires a theme"
	self should: [ e skinManager installNewSkinIn: e ] raise: ToSpaceNotFoundError.
	self deny: e styleInstalled.
	self assert: e skinManager newSkinRequested.
	self assert: e skinManager installedSkin isUnresolvedSkin.
	" need to reset the skin to the initial (unknown skin) because 
	the previous error let the skinManager in an invalid state"
	e skinManager uninstallSkinIn: e.
	space root addChild: e.
	e skinManager installNewSkinIn: e.
	self assert: e skinManager installedSkin isThemeSkin.
	self assert: e styleInstalled
]

{ #category : #tests }
ToSkinInstallerTest >> testInstallSkinInWithErrorNonAttachedInSpace [

	| e |
	e := ToElement new.
	self deny: e skinManager newSkinRequested.
	self deny: e skinManager installedSkin isThemeSkin.
	self
		should: [ e skinManager forceNewSkinRequested: true in: e ]
		raise: Error.
	self assert: e skinManager newSkinRequested.
	self deny: e skinManager installedSkin isThemeSkin.
	" need to reset the skin to the initial (unknown skin) because 
	the previous error let the skinManager in an invalid state"
	e skinManager uninstallSkinIn: e.
	" an element must be attached to a space 
	because installing a skin requires a theme"
	self should: [ e lookupTheme ] raise: ToSpaceNotFoundError.
	self should: [ e skinManager installNewSkinIn: e ] raise: ToSpaceNotFoundError
]
