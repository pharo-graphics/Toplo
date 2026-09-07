Class {
	#name : #ToSkinInstallerTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #tests }
ToSkinInstallerTest >> testApplyOn [

	| e isThemeSkin |
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
	space deferAndSettle: [
		space root addChild: e.
		e skinManager installNewSkinIn: e.
		isThemeSkin := e skinManager installedSkin isThemeSkin ].
	self assert: isThemeSkin
]

{ #category : #tests }
ToSkinInstallerTest >> testApplyOnWithRawSkin [

	| e styleInstalled newSkinRequested isUnresolvedSkin isThemeSkin styleInstalledAfter |
	e := ToElementForRawSkinTest new.
	space toTheme: ToRawTheme new.
	self
		should: [ e skinManager forceNewSkinRequested: true in: e ]
		raise: ToSpaceNotFoundError.
	" an element must be attached to a space 
	because installing a skin requires a theme"
	self should: [ e skinManager installNewSkinIn: e ] raise: ToSpaceNotFoundError.
	styleInstalled := e styleInstalled.
	newSkinRequested := e skinManager newSkinRequested.
	isUnresolvedSkin := e skinManager installedSkin isUnresolvedSkin.
	self deny: styleInstalled.
	self assert: newSkinRequested.
	self assert: isUnresolvedSkin.
	" need to reset the skin to the initial (unknown skin) because 
	the previous error let the skinManager in an invalid state"
	e skinManager uninstallSkinIn: e.
	space deferAndSettle: [
		space root addChild: e.
		e skinManager installNewSkinIn: e.
		isThemeSkin := e skinManager installedSkin isThemeSkin.
		styleInstalledAfter := e styleInstalled ].
	self assert: isThemeSkin.
	self assert: styleInstalledAfter
]

{ #category : #tests }
ToSkinInstallerTest >> testInstallSkinInWithErrorNonAttachedInSpace [

	| e newSkinRequested isThemeSkin |
	e := ToElement new.
	newSkinRequested := e skinManager newSkinRequested.
	isThemeSkin := e skinManager installedSkin isThemeSkin.
	self deny: newSkinRequested.
	self deny: isThemeSkin.
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
