"
A ToThemeManagerTest is a test class for testing the behavior of ToThemeManager
"
Class {
	#name : #ToSkinManagerTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #tests }
ToSkinManagerTest >> testApplySkinInstallerIn [

	| e sk |
	e := ToElement new.
	space root addChild: e.
	e skinManager uninstallSkinIn: e.
	e defaultSkin: (sk := ToRawSkin new).
	self deny: e skinManager installedSkin isKnownSkin.
	self assert: e skinManager skinInstaller notNil.
	e skinManager applySkinInstallerIn: e.
	self assert: e skinManager installedSkin identicalTo: sk.
	self assert: e skinManager skinInstaller isNil
]

{ #category : #tests }
ToSkinManagerTest >> testApplySkinInstallerIn2 [

	| e |
	e := ToElement new.
	" no skinInstaller -> no installed skin  "
	e skinManager applySkinInstallerIn: e.
	self deny: e skinManager installedSkin isKnownSkin.
	e skinManager requestNewSkinIn: e.
	self assert: e skinManager skinInstaller notNil.

]

{ #category : #tests }
ToSkinManagerTest >> testApplySkinUninstallerIn [

	| e sk |
	e := ToElement new. 
	space root addChild: e.
	e skinManager uninstallSkinIn: e.
	e defaultSkin: (sk := ToRawSkin new).
	e skinManager applySkinInstallerIn: e.
	self assert: e skinManager installedSkin identicalTo: sk.
	e skinManager requestUninstallSkinIn: e.
	e skinManager applySkinUninstallerIn: e.
	self deny: e skinManager installedSkin isKnownSkin

	


]

{ #category : #tests }
ToSkinManagerTest >> testApplyStylesIn [

	| e sk |
	e := ToElement new. 
	space root addChild: e.
	e skinManager uninstallSkinIn: e.
	e defaultSkin: (sk := ToRawSkin new).
	e skinManager applySkinInstallerIn: e.
	self assert: e skinManager installedSkin identicalTo: sk.
	self assert: e skinManager skinStateQueue nextStates isEmpty.

]

{ #category : #tests }
ToSkinManagerTest >> testComputedStyleSheetChainIn [

	| e child childchild childchildchild |
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	childchildchild := ToElement new.
	e addChild: child.
	child addChild: childchild.
	childchild addChild: childchildchild.
	" e is not attached -> # ( )"
	self
		assert:
		(childchildchild skinManager computedStyleSheetChainIn: childchildchild)
		equals: #(  ).
	space root addChild: e.
	" no styleSheet theme by default "
	self assert:
		(childchildchild skinManager computedStyleSheetChainIn: childchildchild)
			isEmpty.
	space toTheme: ToStyleSheetTheme new.
	self waitTestingSpaces.

	" one style sheet in theme by default "
	self assert:
		(childchildchild skinManager computedStyleSheetChainIn: childchildchild)
			size equals: 1.
	childchild styleSheet: ToStyleSheet new.
	self
		assert:
		(childchildchild skinManager computedStyleSheetChainIn: childchildchild)
			size
		equals: 2.
	e styleSheet: ToStyleSheet new.
	self
		assert:
		(childchildchild skinManager computedStyleSheetChainIn: childchildchild)
			size
		equals: 3.
	childchild skinManager styleSheet inherits: false.
	self
		assert:
		(childchildchild skinManager computedStyleSheetChainIn: childchildchild)
			size
		equals: 1
]

{ #category : #tests }
ToSkinManagerTest >> testDefaultRawSkin [

	| e sk |
	e := ToElement new. 
	e defaultRawSkin: (sk := ToRawSkin new).
	self assert: e defaultRawSkin identicalTo: sk
]

{ #category : #tests }
ToSkinManagerTest >> testDefaultRawSkinIn [

	| e sk |
	e := ToElement new.
	space root addChild: e.
	e skinManager uninstallSkinIn: e.
	e defaultRawSkin: (sk := ToRawSkin new).
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: e defaultRawSkin identicalTo: sk.
	self deny:
		(e skinManager installedSkin) isKnownSkin.
	self
		assert:
			(e eventDispatcher handlers select: [ :h | h isKindOf: ToRawSkin ])
				size
		equals: 0
]

{ #category : #tests }
ToSkinManagerTest >> testDefaultSkin [

	| e sk |
	e := ToElement new.
	space root addChild: e.
	e defaultSkin: (sk := ToRawSkin new).
	self assert: e defaultSkin identicalTo: sk.
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: e skinManager installedSkin isKnownSkin.
	self waitTestingSpaces.
	self
		assert:
			(e eventDispatcher handlers select: [ :h | h isKindOf: ToRawSkin ])
				size
		equals: 1
]

{ #category : #tests }
ToSkinManagerTest >> testElementRemovedFromSceneGraph [
	" test that a requestUninstallSkin is sent to an element when it is removed from a space. "

	" this ensures that the skin is removed if the element is added back as a child."

	| skin e |
	e := ToElement new.
	space root addChild: e.
	skin := ToSkin new.
	e skinManager uninstallSkinIn: e.
	e skinManager installSkin: skin in: e.
	self assert: e skinManager skinUninstaller isNil.
	space root removeChild: e.
	self assert: e skinManager skinRequestCount isZero
]

{ #category : #tests }
ToSkinManagerTest >> testEnqueueSkinStateIn [

	| w |
	w := ToElement new.
	self assert: w skinManager skinStateQueue nextStates size equals: 0.
	w skinManager skinStateQueue enqueueInstallStateForElement: w.
	" Have a ToInstallState + a ToEnablementState "
	self assert: w skinManager skinStateQueue nextStates size equals: 2.
	w skinManager
		enqueueSkinState:
		(ToTransientState skinEvent: ToHoveredSkinEvent new)
		in: w.
	self assert: w skinManager skinStateQueue nextStates size equals: 3
]

{ #category : #tests }
ToSkinManagerTest >> testEnqueueSkinStateInUnauthorized [

	| w |
	w := ToElement new.
	self assert: w skinManager skinStateQueue nextStates size equals: 0.
	w skinManager
		enqueueSkinState:
		(ToTransientState skinEvent: ToHoveredSkinEvent new)
		in: w.
	" a transient state can't be enqueued if an install state has not be enqueued before "
	self assert: w skinManager skinStateQueue nextStates size equals: 0
]

{ #category : #tests }
ToSkinManagerTest >> testExpectedDefaultSkin [

	| e sk |
	e := ToElement new. 
	e defaultRawSkin: (sk := ToRawSkin new).
	self assert: e defaultRawSkin identicalTo: sk
]

{ #category : #tests }
ToSkinManagerTest >> testForceDefaultSkinIn [

	| e sk |
	e := ToElement new.
	e defaultSkin: (sk := ToRawSkin new).
	self assert: e defaultSkin identicalTo: sk.
	self should: [ e skinManager skinToInstallIn: e ] raise: Error.
	self deny:
		(e skinManager installedSkin) isKnownSkin.
	self deny: e skinManager skinUninstaller notNil.
	self assert: e skinManager skinInstaller notNil
]

{ #category : #tests }
ToSkinManagerTest >> testForceDefaultSkinInWhenInSpace [

	| e sk |
	e := ToElement new.
	space root addChild: e.
	e skinManager uninstallSkinIn: e.
	e defaultSkin: (sk := ToRawSkin new).
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self deny: e skinManager installedSkin isKnownSkin.
	self deny: e skinManager skinUninstaller notNil.
	self assert: e skinManager skinInstaller notNil
]

{ #category : #tests }
ToSkinManagerTest >> testInstallSkinIn [

	| e skin |
	e := ToElement new.
	space root addChild: e.

	skin := ToRawSkin new.
	" the element has an installed skin that must be uninstalled before "
	self should: [e skinManager installSkin: skin in: e] raise: Error.
	e skinManager uninstallSkinIn: e.
	e skinManager installSkin: skin in: e.
	self assert: e skinManager installedSkin identicalTo: skin
]

{ #category : #tests }
ToSkinManagerTest >> testInstallSkinIn2 [

	| e |
	e := ToElement new.
	self deny:
		(e skinManager installedSkin) isKnownSkin.
	" if not theme is found in its parent chain, then an element must be attached to a space. 
	If not, skin installation raises an Error because during skin installation the element theme is lookup "
	space root addChild: e.
	e skinManager uninstallSkinIn: e.
	e skinManager installSkin: (e skinManager skinToInstallIn: e) in: e.
	self assert:
		(e skinManager installedSkin) isKnownSkin.
	self
		assert: (e skinManager installedSkin) class
		equals: (e lookupTheme newSkinFor: e) class
]

{ #category : #tests }
ToSkinManagerTest >> testInstallSkinIn3 [
	| skin e eventHandlerCount |
	e := BlElement new.
	eventHandlerCount := e eventDispatcher handlers size.
	e ensureHaveSkinManager.
	self assert: e skinManager notNil.
	skin := ToSkin new.
	e skinManager installSkin: skin in: e.
	self assert: (e eventDispatcher handlers
			 detect: [ :h | h == skin ]
			 ifNone: [  ]) notNil.
	self assert: e skinManager installedSkin identicalTo: skin.
	self
		assert: e eventDispatcher handlers size
		equals: eventHandlerCount + 1
]

{ #category : #tests }
ToSkinManagerTest >> testInstallSkinInError [

	| e skin debugWasEnabled |
	debugWasEnabled := Bloc debugModeEnabled.
	Bloc debugModeEnabled: true.
	e := ToElement new.
	skin := ToRawSkin new.
	" an error is raised because the element is not attached "
	self should: [ e skinManager installSkin: skin in: e ] raise: Error.

	space root addChild: e.
	self should: [ e skinManager installSkin: skin in: e ] raise: Error.
	e skinManager uninstallSkinIn: e.
	e skinManager installSkin: skin in: e.
	self assert: e skinManager installedSkin isKnownSkin.
	Bloc debugModeEnabled: debugWasEnabled.
]

{ #category : #tests }
ToSkinManagerTest >> testInstalledSkin [

	| e sk |
	e := ToElement new.
	space root addChild: e.
	e defaultSkin: (sk := ToRawSkin new).
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: e skinManager installedSkin isKnownSkin.
	e skinManager uninstallSkinIn: e.
	e skinManager installSkin: sk in: e.
	self assert: (e skinManager installedSkin) identicalTo: sk.
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: e skinManager installedSkin identicalTo: sk.
	self
		assert:
			(e eventDispatcher handlers select: [ :h | h isKindOf: ToRawSkin ])
				size
		equals: 1.
	e skinManager uninstallSkinIn: e.
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self deny: e skinManager installedSkin isKnownSkin.
	self
		assert:
			(e eventDispatcher handlers select: [ :h | h isKindOf: ToRawSkin ])
				size
		equals: 0
]

{ #category : #tests }
ToSkinManagerTest >> testInstalledSkin2 [
	| skin e |
	e := BlElement new.
	e ensureHaveSkinManager.
	skin := ToSkin new.
	e skinManager installSkin: skin in: e.
	self assert: e skinManager installedSkin identicalTo: skin
]

{ #category : #tests }
ToSkinManagerTest >> testInstalledSkinDo [

	| e sk cpt |
	cpt := 0.
	e := ToElement new.
	space root addChild: e.
	e defaultSkin: (sk := ToRawSkin new).
	e skinManager installedSkinDo: [ :s | cpt := cpt + 1 ].
	self assert: cpt equals: 1.
	e skinManager uninstallSkinIn: e.
	e skinManager installSkin: sk in: e.
	e skinManager installedSkinDo: [ :s | cpt := cpt + 1 ].
	self assert: cpt equals: 2.
	e skinManager uninstallSkinIn: e.
	e skinManager installedSkinDo: [ :s | cpt := cpt + 1 ].
	self assert: cpt equals: 2.

]

{ #category : #tests }
ToSkinManagerTest >> testOnInstalledIn [

	| e |
	e := ToElement new.
	self assert: e skinManager skinInstaller isNil.
	e ensuredToStyleStore tokenPropertyIndex changedAction value.
	self assert: e skinManager skinInstaller notNil
]

{ #category : #tests }
ToSkinManagerTest >> testRequestInstaallSkinInWithChildren [

	| e child childchild |
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	e addChild: child.
	child addChild: childchild.
	e skinManager requestInstallSkinIn: e
]

{ #category : #tests }
ToSkinManagerTest >> testRequestInstallSkinIn [

	| e  |
	e := ToElement new.
	space root addChild: e.
	e skinManager requestUninstallSkinIn: e.
	e skinManager requestInstallSkinIn: e.
	" the requestSkin is postpone since the element is not attached "
	self assert: e skinManager skinInstaller notNil.

]

{ #category : #tests }
ToSkinManagerTest >> testRequestInstallSkinInWhenInSpace [

	| e |
	e := ToElement new.
	space root addChild: e.
	self assert: e skinManager skinInstaller isNil	.
	self assert: e skinManager installedSkin isKnownSkin
]

{ #category : #tests }
ToSkinManagerTest >> testRequestSkinInWithChildrenWhenInSpace [

	| e child childchild |
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	e addChild: child.
	child addChild: childchild.
	space root addChild: e.
	" the skin is also Installed in children "
	self assert: e skinManager skinInstaller isNil.
	self assert: child skinManager skinInstaller isNil.
	self assert: childchild skinManager skinInstaller isNil.

]

{ #category : #tests }
ToSkinManagerTest >> testRequestUninstallSkinIn [

	| e |
	e := ToElement new.
	e skinManager requestUninstallSkinIn: e.
	self deny:
		(e skinManager installedSkin) isKnownSkin.
	self deny: e skinManager skinUninstaller notNil.

	" requestSkin has not effect on skinUninstaller "
	e skinManager requestInstallSkinIn: e.
	self deny:
		(e skinManager installedSkin) isKnownSkin.
	self deny: e skinManager skinUninstaller notNil.
	" since not in a space "
	self assert: e skinManager skinInstaller notNil.

	" uninstalling has not effect on skin installer"
	e skinManager applySkinUninstallerIn: e.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller notNil.

]

{ #category : #tests }
ToSkinManagerTest >> testRequestUninstallSkinInWithChildrenWithInstalledSkin [

	| e child childchild |
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	e addChild: child.
	child addChild: childchild.
	space root addChild: e.

	" install skin on the element tree "
	e space applyAllSkinInstallers.
	self assert: e skinManager installedSkin isKnownSkin.
	self assert: e skinManager skinInstaller isNil.
	self assert: child skinManager installedSkin isKnownSkin.
	self assert: child skinManager skinInstaller isNil.
	self assert: childchild skinManager installedSkin isKnownSkin.
	self assert: childchild skinManager skinInstaller isNil.

	e skinManager requestUninstallSkinIn: e.
	self assert: e skinManager skinUninstaller notNil.
	" but installed skin not yet uninstalled "
	self assert: e skinManager installedSkin isKnownSkin.

	" uninstalling "
	e skinManager applySkinUninstallerIn: e.
	self deny: e skinManager installedSkin isKnownSkin.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller isNil.

	" but no effect on children "
	self assert: child skinManager installedSkin isKnownSkin.
	self assert: childchild skinManager installedSkin isKnownSkin.

	e skinManager applySkinInstallerIn: e.
	self deny: e skinManager installedSkin isKnownSkin.
	e ensuredSkinManager requestInstallSkinIn: e.
	e skinManager applySkinInstallerIn: e.
	self assert: e skinManager installedSkin isKnownSkin.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller isNil
]

{ #category : #tests }
ToSkinManagerTest >> testRequestUninstallSkinInWithChildrenWithInstalledSkin2 [

	| e child childchild |
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	e addChild: child.
	child addChild: childchild.
	space root addChild: e.

	" install skin on the element tree "
	e space applyAllSkinInstallers.
	self assert: e skinManager installedSkin isKnownSkin.
	self assert: e skinManager skinInstaller isNil.
	self assert: child skinManager skinInstaller isNil.
	self assert: childchild skinManager installedSkin isKnownSkin.
	self assert: childchild skinManager skinInstaller isNil.

	e skinManager requestUninstallSkinIn: e.

	self assert: e skinManager skinUninstaller notNil.
	self assert: child skinManager skinUninstaller isNil.
	self assert: childchild skinManager skinUninstaller isNil.
	" but installed skin not yet uninstalled "
	self assert: e skinManager installedSkin isKnownSkin.
	self assert: child skinManager installedSkin isKnownSkin.
	self assert: childchild skinManager installedSkin isKnownSkin.

	e skinManager applySkinUninstallerIn: e.
	self deny: e skinManager installedSkin isKnownSkin.

	" trying to install here should not results in an installed skin because no installer has been requested "
	e skinManager applySkinReinstallIn: e.
	self deny: e skinManager installedSkin isKnownSkin.

	self assert: child skinManager installedSkin isKnownSkin.
	self assert: childchild skinManager installedSkin isKnownSkin
]

{ #category : #tests }
ToSkinManagerTest >> testRequestUninstallSkinInWithInstalledSkin [

	| e |
	e := ToElement new.
	" to ensure that the element has an installed skin "
	space root addChild: e.
	e skinManager applySkinReinstallIn: e.
	self assert: e skinManager skinInstaller isNil.

	e skinManager requestUninstallSkinIn: e.
	self assert: e skinManager skinUninstaller notNil.
	" but installed skin not yet uninstalled "
	self assert: e skinManager installedSkin isKnownSkin.

	" uninstalling "
	e skinManager applySkinUninstallerIn: e.
	self deny: e skinManager installedSkin isKnownSkin.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller isNil
]

{ #category : #tests }
ToSkinManagerTest >> testSetDefaultRawSkinIn [

	| e sk |
	e := ToElement new.
	e defaultRawSkin: (sk := ToRawSkin new).
	self assert: e defaultRawSkin identicalTo: sk.
	self assert: e defaultSkin isNil.
	self should: [ e skinManager skinToInstallIn: e ] raise: Error.
	space root addChild: e.
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: e skinManager installedSkin isKnownSkin.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller isNil
]

{ #category : #tests }
ToSkinManagerTest >> testSetDefaultSkinIn [

	| e sk |
	e := ToElement new.
	space root addChild: e.
	e defaultSkin: (sk := ToRawSkin new).
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: e defaultSkin identicalTo: sk.
	self assert: e skinManager installedSkin isKnownSkin.
	self waitTestingSpaces.
	self
		assert:
			(e eventDispatcher handlers select: [ :h | h isKindOf: ToRawSkin ])
				size
		equals: 1
]

{ #category : #tests }
ToSkinManagerTest >> testSetStyleSheetIn [

	| e |
	e := ToElement new.
	e skinManager setStyleSheet: ToStyleSheet new in: e.
	self assert: e skinManager styleSheet notNil
]

{ #category : #tests }
ToSkinManagerTest >> testSkinInstaller [

	| e child childchild |
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	e addChild: child.
	child addChild: childchild.

	self assert: e skinManager skinInstaller isNil.
	self assert: child skinManager skinInstaller isNil.
	self assert: childchild skinManager skinInstaller isNil.

	self assert: e skinManager skinInstaller isNil.
	space root addChild: e.
	" first skinInstaller is applied  "
	self assert: e skinManager skinInstaller isNil.
	self assert: child skinManager skinInstaller isNil.
	self assert: childchild skinManager skinInstaller isNil
]

{ #category : #tests }
ToSkinManagerTest >> testSkinInstaller2 [

	| e child childchild |
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	e addChild: child.
	child addChild: childchild.

	self assert: e skinManager skinInstaller isNil.
	self assert: child skinManager skinInstaller isNil.
	self assert: childchild skinManager skinInstaller isNil.

	e ensuredSkinManager requestInstallSkinIn: e.
	self assert: e skinManager skinInstaller notNil
]

{ #category : #tests }
ToSkinManagerTest >> testSkinStateQueue [

	| e |
	e := ToElement new.
	self assert: e skinManager skinStateQueue notNil
]

{ #category : #tests }
ToSkinManagerTest >> testSkinUninstaller [

	| e child childchild |
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	e addChild: child.
	child addChild: childchild.

	self assert: e skinManager skinUninstaller isNil.
	self assert: child skinManager skinUninstaller isNil.
	self assert: childchild skinManager skinUninstaller isNil.

	space root addChild: e.
	self assert: e skinManager skinInstaller isNil.
	self assert: e skinManager skinUninstaller isNil.
	" child skinInstaller is set explicitely with requestUninstallSkin "
	self assert: child skinManager skinUninstaller isNil.
	self assert: childchild skinManager skinUninstaller isNil
]

{ #category : #tests }
ToSkinManagerTest >> testSkinUninstallerWithToThemeChanged [

	| e child childchild |
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	e addChild: child.
	child addChild: childchild.

	self assert: e skinManager skinUninstaller isNil.
	self assert: child skinManager skinUninstaller isNil.
	self assert: childchild skinManager skinUninstaller isNil.

	space root addChild: e.
	e toThemeInstalled.
	self assert: e skinManager skinInstaller notNil.
	self assert:
		(e skinManager installedSkin) isKnownSkin.
	self assert: e skinManager skinUninstaller notNil.
	self assert:
		(child skinManager installedSkin) isKnownSkin.
	self assert: child skinManager skinUninstaller notNil.
	self assert:
		(childchild skinManager installedSkin) isKnownSkin.
	self assert: childchild skinManager skinUninstaller notNil
]

{ #category : #tests }
ToSkinManagerTest >> testStyleSheet [

	self testSetStyleSheetIn 
]

{ #category : #tests }
ToSkinManagerTest >> testUninstallSkinIn [

	| e skin |
	e := ToElement new.
	space root addChild: e.
	skin := ToRawSkin new.
	e skinManager uninstallSkinIn: e.
	self deny: e skinManager installedSkin isKnownSkin.
	e skinManager installSkin: skin in: e.
	self assert: e skinManager installedSkin isKnownSkin.
	e skinManager uninstallSkinIn: e.
	self deny: e skinManager installedSkin isKnownSkin
]

{ #category : #tests }
ToSkinManagerTest >> testUninstallSkinIn2 [

	| skin e eventHandlerCount |
	e := ToElement new.
	e ensureHaveSkinManager.
	eventHandlerCount := e eventDispatcher handlers size.
	space root addChild: e.
	" initialize the theme to avoid the indirect instalation 
	of a new skin which would make the test fail"
	space toTheme.
	self assert: e skinManager notNil.
	skin := ToRawSkin new.
	e skinManager uninstallSkinIn: e.
	e skinManager installSkin: skin in: e.
	" the assert is ok here because the theme has been initialized before "
	self assert: e skinManager installedSkin identicalTo: skin.
	" one more event handler, a ToElementInitializeEventHandler is added"
	self
		assert: e eventDispatcher handlers size
		equals: eventHandlerCount + 1.
	self assert: (e eventDispatcher handlers
			 select: [ :h | h isKindOf: ToElementInitializeEventHandler ]) size = 1.
	e skinManager uninstallSkinIn: e.
	self
		assert: e eventDispatcher handlers size
		equals: eventHandlerCount.
	self assert: e skinManager notNil.
	self
		assert: e skinManager installedSkin
		identicalTo: ToUnknownSkin instance
]
