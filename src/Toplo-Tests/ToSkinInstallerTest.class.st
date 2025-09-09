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
	space root addChild: e.
	e skinManager installNewSkinIn: e.
	self assert: e skinManager installedSkin isKnownSkin
]

{ #category : #tests }
ToSkinInstallerTest >> testApplyOnWithRawSkin [

	| e |
	e := ToElementForRawSkinTest new.
	space toTheme: ToRawTheme new.
	self
		should: [ e skinManager forceNewSkinRequested: true in: e ]
		raise: Error.
	" an element must be attached to a space 
	because installing a skin requires a theme"
	self should: [ e skinManager installNewSkinIn: e ] raise: Error.
	self deny: e styleInstalled.
	self assert: e skinManager newSkinRequested.
	space root addChild: e.
	e skinManager installNewSkinIn: e.
	self assert: e skinManager installedSkin isKnownSkin.
	self assert: e styleInstalled
]

{ #category : #tests }
ToSkinInstallerTest >> testInstallSkinInWithErrorNonAttachedInSpace [

	| e |
	e := ToElement new.
	self deny: e skinManager newSkinRequested.
	self deny: e skinManager installedSkin isKnownSkin.
	self
		should: [ e skinManager forceNewSkinRequested: true in: e ]
		raise: Error.
	self assert: e skinManager newSkinRequested.
	self deny: e skinManager installedSkin isKnownSkin.
	" an element must be attached to a space 
	because installing a skin requires a theme"
	self should: [ e lookupTheme ] raise: Error.
	self should: [ e skinManager installNewSkinIn: e ] raise: Error
]
