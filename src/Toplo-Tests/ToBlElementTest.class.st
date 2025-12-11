Class {
	#name : #ToBlElementTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core'
}

{ #category : #tests }
ToBlElementTest >> testApplicableListenersFor [

	| e theme |
	e := BlElement new.
	theme := ToStyleSheetThemeForTest new.
	space toTheme: theme.
	space root addChild: e.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: (theme applicableListenersFor: e) size equals: 0
	
]

{ #category : #tests }
ToBlElementTest >> testBlElementShouldNotHaveSkinManager [

	| dem |
	dem := BlElement new.
	dem background: Color red.
	dem border: Color black.
	self assert: dem skinManager isNil.
	space root addChild: dem.
	self assert: dem skinManager isNil.
	self waitTestingSpaces.
	self assert: dem skinManager isNil.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: dem skinManager isNil.

]

{ #category : #tests }
ToBlElementTest >> testBlElementShouldNotHaveSkinManagerEvenAsChildOfAToElement [

	| dem pane |
	pane := ToPane vertical.
	dem := BlElement new.
	dem background: Color red.
	dem border: Color black.
	pane addChild: dem.
	self assert: dem skinManager isNil.
	space root addChild: pane.
	self assert: dem skinManager isNil.
	self waitTestingSpaces.
	self assert: dem skinManager isNil.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: dem skinManager isNil.



]

{ #category : #tests }
ToBlElementTest >> testElementRemovedFromSceneGraph [
	" test that a requestUninstallSkin is sent to an element when it is removed from a space. "
	" this ensures that the skin is removed if the element is added back as a child."

	| e |
	e := BlElement new.
	space root addChild: e.
	self assert: e skinManager isNil.
	space root removeChild: e.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: e skinManager isNil.

	
	
]

{ #category : #tests }
ToBlElementTest >> testEnsureCanManageSkin [

	| e |
	e := BlElement new.
	e ensureCanManageSkin.
	space root addChild: e.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: e skinManager installedSkin isKnownSkin 
]

{ #category : #'tests - stamp' }
ToBlElementTest >> testHasStamp [

	| e |
	e := BlElement new.
	self deny: e hasStamp.

	e addStamp: #test.
	self assert: e hasStamp.

	e removeStamp: #test.
	self deny: e hasStamp.
]

{ #category : #tests }
ToBlElementTest >> testRequestSkin [

	| e |
	e := BlElement new.
	self assert: e skinManager isNil.
	self assert: e skinManager isNil.
	self assert: e skinManager isNil.
	e ensuredSkinManager requestNewSkinIn: e.
	self assert: e skinManager newSkinRequested.
	self assert: e skinManager installedSkin isUnknownSkin .
	space root addChild: e.
	self assert: e skinManager newSkinRequested.
	self assert: e skinManager installedSkin isUnknownSkin.
	space applyAllSkinInstallers.
	self deny: e skinManager newSkinRequested.
	self assert: e skinManager installedSkin isKnownSkin 
	
]

{ #category : #tests }
ToBlElementTest >> testRequestSkin2 [

	| e |
	e := BlElement new.
	self assert: e skinManager isNil.
	self assert: e skinManager isNil.
	self assert: e skinManager isNil.
	space root addChild: e.
	self assert: e skinManager isNil.
	e ensuredSkinManager requestNewSkinIn: e.
	self assert: e skinManager notNil.
	self deny: e skinManager newSkinRequested.
	self assert: e skinManager installedSkin isKnownSkin.
	" apply skin installer from space has no effect on e since it has no skinInstaller "
	space applyAllSkinInstallers.
	self deny: e skinManager newSkinRequested.
	self assert: e skinManager installedSkin isKnownSkin
]

{ #category : #tests }
ToBlElementTest >> testUnsortedApplicableListenersFor [

	| e theme |
	e := BlElement new.
	theme := ToStyleSheetThemeForTest new.
	space toTheme: theme.
	space root addChild: e.
	self assert: (theme unsortedApplicableListenersFor: e) size equals: 0.
	e := ToElement new.
	space root addChild: e.
	self assert: (theme unsortedApplicableListenersFor: e) size equals: 5.

	
]

{ #category : #'tests - stamp' }
ToBlElementTest >> testValueOfTokenNamed [

	| e theme |
	e := BlElement new.
	e ensureCanManageSkin.
	theme := ToRawThemeForTest new.
	space toTheme: theme.
	space root addTokenNamed: #testToken withValue: Color blue.
	space root addChild: e.
	self assert: (e valueOfTokenNamed: #testToken) equals: Color blue
]

{ #category : #'tests - stamp' }
ToBlElementTest >> testValueOfTokenNamed2 [

	| e theme |
	e := BlElement new.
	e ensureCanManageSkin.
	theme := ToRawThemeForTest new.
	space root addTokenNamed: #testToken withValue: Color blue.
	space toTheme: theme.
	space root addChild: e.
	self assert: (e valueOfTokenNamed: #testToken) equals: Color blue
]

{ #category : #'tests - stamp' }
ToBlElementTest >> testValueOfTokenNamedWithNotFoundToken [

	| e theme notFoundDispatched |
	e := BlElement new.
	e ensureCanManageSkin.
	theme := ToRawThemeForTest new.
	space root addTokenNamed: #testToken withValue: Color blue.
	" normally, the token should not be found because the element is not added in the space root. 
	The fallback procedure is applied. see BlElement>>valueOfTokenNamed:"
	notFoundDispatched := false.
	e
		addEventHandlerOn: ToTokenPropertyNotFoundEvent
		do: [ notFoundDispatched := true ].
	self
		should: [ e valueOfTokenNamed: #testToken ]
		raise: ToTokenPropertyNotFoundError.
	self assert: notFoundDispatched.
	e addTokenNamed: #testToken withValue: Color blue.
	self assert: (e valueOfTokenNamed: #testToken) equals: Color blue.
	e addTokenNamed: #testToken withValue: Color yellow.
	space root addChild: e.
	self assert: (e valueOfTokenNamed: #testToken) equals: Color yellow.
	e removeFromParent.
	self assert: (e valueOfTokenNamed: #testToken) equals: Color yellow
]
