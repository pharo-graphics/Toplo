"
A ToThemeManagerTest is a test class for testing the behavior of ToThemeManager
"
Class {
	#name : #ToSkinManagerTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #tests }
ToSkinManagerTest >> testApplySkinInstallerIn [

	| e sk |
	e := ToElement new.
	space root addChild: e.
	e skinManager setDefaultSkin: (sk := ToRawSkin new) in: e.
	self assert:
		(e skinManager installedSkin) isNil.
	self assert: e skinManager installedSkin isNil.
	self assert: e skinManager hasPostponedInstallSkinHandler not.
	self assert: e skinManager skinInstaller notNil.
	e skinManager applySkinInstallerIn: e.
	self assert: e skinManager installedSkin identicalTo: sk.
	self assert: e skinManager skinInstaller isNil
]

{ #category : #tests }
ToSkinManagerTest >> testApplySkinInstallerIn2 [

	| e |
	e := ToElement new.
	" no skinInstaller -> error "
	self should: [ e skinManager applySkinInstallerIn: e ] raise: Error.
	e skinManager requestNewSkinIn: e.
	self assert: e skinManager hasPostponedInstallSkinHandler
]

{ #category : #tests }
ToSkinManagerTest >> testApplySkinUninstallerIn [

	| e sk |
	e := ToElement new. 
	space root addChild: e.
	e skinManager setDefaultSkin: (sk := ToRawSkin new) in: e.
	e skinManager applySkinInstallerIn: e.
	self assert: e skinManager installedSkin identicalTo: sk.
	e skinManager requestUninstallSkinIn: e.
	e skinManager applySkinUninstallerIn: e.
	self assert: e skinManager installedSkin isNil

	


]

{ #category : #tests }
ToSkinManagerTest >> testApplyStylesIn [

	| e sk |
	e := ToElement new. 
	space root addChild: e.
	e skinManager setDefaultSkin: (sk := ToRawSkin new) in: e.
	e skinManager applySkinInstallerIn: e.
	self assert: e skinManager installedSkin identicalTo: sk.
	self assert: e skinManager skinStateQueue nextStates isEmpty.

]

{ #category : #tests }
ToSkinManagerTest >> testBorderBuilder [

	| e  |
	e := ToElement new.
	e skinManagerDo: [ :skm | skm ensureHaveSkinContext ].
	self assert: (e skinManager borderBuilder ) notNil
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
	space := BlSpace new.
	space root addChild: e.
	" no styleSheet theme by default "
	self assert:
		(childchildchild skinManager computedStyleSheetChainIn: childchildchild)
			isEmpty.
	space toTheme: ToStyleSheetTheme light.
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
	self assert: e skinManager defaultRawSkin identicalTo: sk
]

{ #category : #tests }
ToSkinManagerTest >> testDefaultRawSkinIn [

	| e sk |
	e := ToElement new.
	space root addChild: e.
	e skinManager setDefaultRawSkin: (sk := ToRawSkin new) in: e.
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: e skinManager defaultRawSkin identicalTo: sk.
	self assert:
		(e skinManager installedSkin) isNil.
	self assert: e skinManager installedSkin isNil.
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
	self assert: e skinManager defaultSkin identicalTo: sk.
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: e skinManager installedSkin isNil.
	self
		assert:
			(e eventDispatcher handlers select: [ :h | h isKindOf: ToRawSkin ])
				size
		equals: 0
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
		(ToTransientState lookEvent: ToHoveredLookEvent new)
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
		(ToTransientState lookEvent: ToHoveredLookEvent new)
		in: w.
	" a transient state can't be enqueued if an install state has not be enqueued before "
	self assert: w skinManager skinStateQueue nextStates size equals: 0
]

{ #category : #tests }
ToSkinManagerTest >> testEnsureHaveSkinContext [

	| e |
	e := ToElement new.
	self assert: e skinManager skinContext isNil.
	e skinManager ensureHaveSkinContext.
	self assert: e skinManager skinContext notNil.

]

{ #category : #tests }
ToSkinManagerTest >> testExpectedDefaultSkin [

	| e sk |
	e := ToElement new. 
	e defaultRawSkin: (sk := ToRawSkin new).
	self assert: e skinManager defaultRawSkin identicalTo: sk
]

{ #category : #tests }
ToSkinManagerTest >> testForceDefaultSkinIn [

	| e sk |
	e := ToElement new.
	e skinManager setDefaultSkin: (sk := ToRawSkin new) in: e.
	self assert: e skinManager defaultSkin identicalTo: sk.
	self should: [ e skinManager skinToInstallIn: e ] raise: Error.
	self assert:
		(e skinManager installedSkin) isNil.
	self assert: e skinManager installedSkin isNil.
	self deny: e skinManager skinUninstaller notNil.
	self assert: e skinManager hasPostponedInstallSkinHandler.
	self assert: e skinManager skinInstaller isNil
]

{ #category : #tests }
ToSkinManagerTest >> testForceDefaultSkinInWhenInSpace [

	| e sk |
	e := ToElement new.
	space root addChild: e.
	e skinManager setDefaultSkin: (sk := ToRawSkin new) in: e.
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: e skinManager installedSkin isNil.
	self deny: e skinManager skinUninstaller notNil.
	self assert: e skinManager hasPostponedInstallSkinHandler not.
	self assert: e skinManager skinInstaller notNil
]

{ #category : #tests }
ToSkinManagerTest >> testHasPostponedInstallSkinHandler [

	| e handlersNb |
	e := ToElement new.
	self assert: e skinManager hasPostponedInstallSkinHandler not.
	handlersNb := e eventDispatcher handlers size.
	e skinManager postponeRequestSkinIn: e.
	self assert: e skinManager hasPostponedInstallSkinHandler.
	self
		assert: e eventDispatcher handlers size
		equals: handlersNb + 1.
	self assert: e skinManager skinInstaller isNil.
	
	" the postpone action is runned when BlElementAddedToSceneGraph is sent "	
	space root addChild: e.
	self assert: e skinManager hasPostponedInstallSkinHandler not.
	" should have 2 more event handlers (the skinStateGenerator + the one for postponedRequestInstallSkin)"
	self
		assert: e eventDispatcher handlers size
		equals: handlersNb.
	self assert: e skinManager skinInstaller notNil

	

]

{ #category : #tests }
ToSkinManagerTest >> testInstallSkinIn [

	| e skin |
	e := ToElement new.
	skin := ToRawSkin new.
	e skinManager installSkin: skin in: e.
	self assert: e skinManager installedSkin notNil
]

{ #category : #tests }
ToSkinManagerTest >> testInstallSkinIn2 [

	| e |
	e := ToElement new.
	self assert:
		(e skinManager installedSkin) isNil.
	" if not theme is found in its parent chain, then an element must be attached to a space. 
	If not, skin installation raises an Error because during skin installation the element theme is lookup "
	space root addChild: e.
	e skinManager installSkin: (e skinManager skinToInstallIn: e) in: e.
	self assert:
		(e skinManager installedSkin) notNil.
	self
		assert: (e skinManager installedSkin) class
		equals: (e toTheme newSkinFor: e) class
]

{ #category : #tests }
ToSkinManagerTest >> testInstalledSkin [

	| e sk |
	e := ToElement new.
	space root addChild: e.
	e defaultSkin: (sk := ToRawSkin new).
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert:
		(e skinManager installedSkin) isNil.
	self assert: e skinManager installedSkin isNil.
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
	self assert: e skinManager installedSkin isNil.
	self
		assert:
			(e eventDispatcher handlers select: [ :h | h isKindOf: ToRawSkin ])
				size
		equals: 0
]

{ #category : #tests }
ToSkinManagerTest >> testInstalledSkinDo [

	| e sk cpt |
	cpt := 0.
	e := ToElement new. 
	e defaultSkin: (sk := ToRawSkin new).
	e skinManager installedSkinDo: [ :s | cpt := cpt + 1 ].
	self assert: cpt isZero.
	e skinManager installSkin: sk in: e.
	e skinManager installedSkinDo: [ :s | cpt := cpt + 1 ].
	self assert: cpt equals: 1.
	e skinManager uninstallSkinIn: e.
	e skinManager installedSkinDo: [ :s | cpt := cpt + 1 ].
	self assert: cpt equals: 1.

]

{ #category : #tests }
ToSkinManagerTest >> testIsRequestSkinPostponed [

	| e |
	e := ToElement new.
	self assert: e skinManager hasPostponedInstallSkinHandler not.
	e skinManager requestInstallSkinIn: e.
	" since the element is not attached to a space, the request skin is postponed "
	self assert: e skinManager hasPostponedInstallSkinHandler.
	self assert: e skinManager skinInstaller isNil

]

{ #category : #tests }
ToSkinManagerTest >> testIsRequestSkinPostponed2 [

	| e |
	e := ToElement new.
	self assert: e skinManager hasPostponedInstallSkinHandler not.
	space root addChild: e.
	" since the element is attached to a space, no request skin postponed "
	self assert: e skinManager hasPostponedInstallSkinHandler not.
	self assert: e skinManager skinInstaller notNil

]

{ #category : #tests }
ToSkinManagerTest >> testIsSetUpForTheme [

	| e theme skin |
	e := ToElement new.
	space := BlSpace new.
	theme := ToRawTheme light.
	self deny: (e skinManager isSetUpForTheme: theme).
	self assert: e skinManager registeredThemeClasses isEmpty.
	self assert: ((theme newSkinFor: e) isKindOf: ToRawSkin).
	space root addChild: e.
	skin := theme newSkinFor: e.
	self assert: e skinManager registeredThemeClasses size equals: 1.
	self assert: e skinManager registeredThemeClasses anyOne equals: ToRawTheme
]

{ #category : #tests }
ToSkinManagerTest >> testOnInstalledIn [

	| e |
	e := ToElement new.
	self assert: e skinManager registeredThemeClasses notNil.
	self assert: e skinManager registeredThemeClasses isEmpty.
	self deny: e skinManager hasPostponedInstallSkinHandler.
	self assert: e skinManager skinInstaller isNil.
	e ensuredToStyleStore tokenPropertyIndex changedAction value.
	self assert: e skinManager hasPostponedInstallSkinHandler.
	self assert: e skinManager skinInstaller isNil
]

{ #category : #tests }
ToSkinManagerTest >> testOnUninstalledIn [

	| e |
	e := ToElement new.
	self assert: (e eventDispatcher handlers
			 detect: [ :h | h isKindOf: ToSkinManagerEventHandler ]
			 ifNone: [  ]) notNil.
	self assert: e skinManager registeredThemeClasses notNil.
	self assert: e skinManager skinInstaller isNil.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinManagementEventHandler notNil.
	e skinManager onUninstalledIn: e.
	e eventDispatcher handlers noneSatisfy: [ :h |
		h isKindOf: ToSkinManagerEventHandler ].
	self assert: e skinManager skinInstaller isNil.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinManagementEventHandler isNil
]

{ #category : #tests }
ToSkinManagerTest >> testPostponeRequestSkinIn [

	| e handlersNb |
	e := ToElement new.
	self assert: e skinManager hasPostponedInstallSkinHandler not.
	handlersNb := e eventDispatcher handlers size.
	e skinManager postponeRequestSkinIn: e.
	self assert: e skinManager hasPostponedInstallSkinHandler.
	self
		assert: e eventDispatcher handlers size
		equals: handlersNb + 1.
	self assert: e skinManager skinInstaller isNil.
	
	" the postpone action is runned when BlElementAddedToSceneGraph is sent "	
	space root addChild: e.
	self assert: e skinManager hasPostponedInstallSkinHandler not.
	" should have 2 more event handlers (the skinStateGenerator + the one for postponedRequestInstallSkin)"
	self
		assert: e eventDispatcher handlers size
		equals: handlersNb.
	self assert: e skinManager skinInstaller notNil

	

]

{ #category : #tests }
ToSkinManagerTest >> testRegisterTheme [

	| e |
	e := ToElement new.
	self assert: e skinManager registeredThemeClasses notNil.
	self assert: e skinManager registeredThemeClasses isEmpty.
	e skinManager registerTheme: ToRawTheme light.
	self assert: e skinManager registeredThemeClasses size equals: 1.
	self
		assert: e skinManager registeredThemeClasses anyOne
		equals: ToRawTheme
]

{ #category : #tests }
ToSkinManagerTest >> testRegisteredThemeClasses [

	| e |
	e := ToElement new.
	self assert: e skinManager registeredThemeClasses notNil.
	self assert: e skinManager registeredThemeClasses isEmpty.
	e skinManager setUp: e forTheme: ToRawTheme light.
	self assert: e skinManager registeredThemeClasses size equals: 1.
	self
		assert: e skinManager registeredThemeClasses anyOne
		equals: ToRawTheme
]

{ #category : #tests }
ToSkinManagerTest >> testRequestInstaallSkinInWithChildren [

	| e child childchild |
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	e addChild: child.
	child addChild: childchild.
	self assert: e skinManager hasPostponedInstallSkinHandler not.
	e skinManager requestInstallSkinIn: e.
	" the requestSkin is postpone since the element is not attached "
	self assert: e skinManager hasPostponedInstallSkinHandler.
	self assert: child skinManager hasPostponedInstallSkinHandler not.
	self assert: childchild skinManager hasPostponedInstallSkinHandler not.

]

{ #category : #tests }
ToSkinManagerTest >> testRequestInstallSkinIn [

	| e  |
	e := ToElement new.
	self assert: e skinManager hasPostponedInstallSkinHandler not.
	e skinManager requestInstallSkinIn: e.
	" the requestSkin is postpone since the element is not attached "
	self assert: e skinManager hasPostponedInstallSkinHandler.

]

{ #category : #tests }
ToSkinManagerTest >> testRequestInstallSkinInWhenInSpace [

	| e |
	e := ToElement new.
	space root addChild: e.
	" the requestSkin is not postpone since the element is attached "
	self assert: e skinManager hasPostponedInstallSkinHandler not.
	self assert: e skinManager skinInstaller notNil
]

{ #category : #tests }
ToSkinManagerTest >> testRequestSkinInWithChildrenWhenInSpace [

	| e child childchild |
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	e addChild: child.
	child addChild: childchild.
	self assert: e skinManager hasPostponedInstallSkinHandler not.
	space root addChild: e.
	" the skinInstalled is added also on children "
	self assert: e skinManager skinInstaller notNil.
	self assert: child skinManager skinInstaller notNil.
	self assert: childchild skinManager skinInstaller notNil.

]

{ #category : #tests }
ToSkinManagerTest >> testRequestUninstallSkinIn [

	| e |
	e := ToElement new.
	e skinManager requestUninstallSkinIn: e.
	self assert:
		(e skinManager installedSkin) isNil.
	self deny: e skinManager skinUninstaller notNil.

	" requestSkin has not effect on skinUninstaller "
	e skinManager requestInstallSkinIn: e.
	self assert:
		(e skinManager installedSkin) isNil.
	self deny: e skinManager skinUninstaller notNil.
	self assert: e skinManager hasPostponedInstallSkinHandler.
	self assert: e skinManager skinInstaller isNil.

	" uninstalling has not effect on skin installer"
	e skinManager applySkinUninstallerIn: e.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller isNil.
	self assert: e skinManager hasPostponedInstallSkinHandler
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
	self assert:
		(e skinManager installedSkin) notNil.
	self assert: e skinManager skinInstaller isNil.
	self assert:
		(child skinManager installedSkin) notNil.
	self assert: child skinManager skinInstaller isNil.
	self assert:
		(childchild skinManager installedSkin) notNil.
	self assert: childchild skinManager skinInstaller isNil.

	e skinManager requestUninstallSkinIn: e.
	self assert: e skinManager skinUninstaller notNil.
	" but installed skin not yet uninstalled "
	self assert:
		(e skinManager installedSkin) notNil.

	" uninstalling "
	e skinManager applySkinUninstallerIn: e.
	self assert: e skinManager installedSkin isNil.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller isNil.

	" but no effect on children "
	self assert: child skinManager installedSkin notNil.
	self assert: childchild skinManager installedSkin notNil.

	self should: [ e skinManager applySkinInstallerIn: e ] raise: Error.
	e ensuredSkinManager requestInstallSkinIn: e.
	e skinManager applySkinInstallerIn: e.
	self assert: e skinManager installedSkin notNil.
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
	self assert: e skinManager installedSkin notNil.
	self assert: e skinManager skinInstaller isNil.
	self assert: child skinManager skinInstaller isNil.
	self assert: childchild skinManager installedSkin notNil.
	self assert: childchild skinManager skinInstaller isNil.

	e skinManager requestUninstallSkinIn: e.

	self assert: e skinManager skinUninstaller notNil.
	self assert: child skinManager skinUninstaller isNil.
	self assert: childchild skinManager skinUninstaller isNil.
	" but installed skin not yet uninstalled "
	self assert: e skinManager installedSkin notNil.
	self assert: child skinManager installedSkin notNil.
	self assert: childchild skinManager installedSkin notNil.

	e skinManager applySkinUninstallerIn: e.
	self assert: e skinManager installedSkin isNil.

	" trying to install here should raise an error because no installer has been requested "
	self should: [ e skinManager applySkinReinstallIn: e ] raise: Error.

	self assert: child skinManager installedSkin notNil.
	self assert: childchild skinManager installedSkin notNil
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
	self assert: e skinManager installedSkin notNil.

	" uninstalling "
	e skinManager applySkinUninstallerIn: e.
	self assert: e skinManager installedSkin isNil.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller isNil
]

{ #category : #tests }
ToSkinManagerTest >> testSetDefaultRawSkinIn [

	| e sk |
	e := ToElement new.
	e skinManager setDefaultRawSkin: (sk := ToRawSkin new) in: e.
	self assert: e skinManager defaultRawSkin identicalTo: sk.
	self assert: e skinManager defaultSkin isNil.
	self should: [ e skinManager skinToInstallIn: e ] raise: Error.
	space root addChild: e.
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: e skinManager installedSkin isNil.
	self deny: e skinManager skinUninstaller notNil.
	self assert: e skinManager skinInstaller notNil
]

{ #category : #tests }
ToSkinManagerTest >> testSetDefaultSkinIn [

	| e sk |
	e := ToElement new.
	space root addChild: e.
	e skinManager setDefaultSkin: (sk := ToRawSkin new) in: e.
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: e skinManager defaultSkin identicalTo: sk.
	self assert: e skinManager installedSkin isNil.
	self
		assert:
			(e eventDispatcher handlers select: [ :h | h isKindOf: ToRawSkin ])
				size
		equals: 0
]

{ #category : #tests }
ToSkinManagerTest >> testSetStyleSheetIn [

	| e |
	e := ToElement new.
	e skinManager setStyleSheet: ToStyleSheet new in: e.
	self assert: e skinManager styleSheet notNil
]

{ #category : #tests }
ToSkinManagerTest >> testSetUpForTheme [

	| e theme |
	e := ToElement new.
	self assert: e skinManager registeredThemeClasses notNil.
	self assert: e skinManager registeredThemeClasses isEmpty.
	theme := ToRawTheme light.
	self deny: (e skinManager isSetUpForTheme: theme).
	e skinManager setUp: e forTheme: theme.
	self assert: (e skinManager isSetUpForTheme: theme).
	self assert: e skinManager registeredThemeClasses size equals: 1.
	self
		assert: e skinManager registeredThemeClasses anyOne
		equals: ToRawTheme.
	e skinManager setUp: e forTheme: ToRawTheme light.
	self assert: e skinManager registeredThemeClasses size equals: 1.
	self
		assert: e skinManager registeredThemeClasses anyOne
		equals: ToRawTheme
]

{ #category : #tests }
ToSkinManagerTest >> testSetUpForThemeIn2 [

	| e theme skin |
	e := ToElement new.
	space := BlSpace new.
	self assert: e skinManager registeredThemeClasses notNil.
	self assert: e skinManager registeredThemeClasses isEmpty.
	theme := ToRawTheme light.
	space root addChild: e.
	skin := theme newSkinFor: e.
	self assert: e skinManager registeredThemeClasses size equals: 1.
	self
		assert: e skinManager registeredThemeClasses anyOne
		equals: ToRawTheme
]

{ #category : #tests }
ToSkinManagerTest >> testSkinContext [

	| e |
	e := ToElement new.
	self assert: e skinManager skinContext isNil.
	e skinManagerDo: [ :skm | skm ensureHaveSkinContext ].
	self assert: e skinManager skinContext notNil
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

	space root addChild: e.
	self assert: e skinManager skinInstaller notNil.
	self assert: child skinManager skinInstaller notNil.
	self assert: childchild skinManager skinInstaller notNil
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
	self assert: e skinManager skinInstaller isNil.
	self assert: e skinManager hasPostponedInstallSkinHandler
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
	self assert: e skinManager skinInstaller notNil.
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
	e toThemeChanged.
	self assert: e skinManager skinInstaller notNil.
	self assert:
		(e skinManager installedSkin) isNil.
	self deny: e skinManager skinUninstaller notNil.
	self assert:
		(child skinManager installedSkin) isNil.
	self deny: child skinManager skinUninstaller notNil.
	self assert:
		(childchild skinManager installedSkin) isNil.
	self deny: childchild skinManager skinUninstaller notNil
]

{ #category : #tests }
ToSkinManagerTest >> testStyleSheet [

	self testSetStyleSheetIn 
]

{ #category : #tests }
ToSkinManagerTest >> testTextAttributesBuilder [

	| e |
	e := ToElement new.
	e skinManagerDo: [ :skm | skm ensureHaveSkinContext ].
	self assert: e skinManager textAttributesBuilder notNil
]

{ #category : #tests }
ToSkinManagerTest >> testUninstallSkinIn [

	| e skin |
	e := ToElement new.
	skin := ToRawSkin new.
	e skinManager installSkin: skin in: e.
	self assert: e skinManager installedSkin notNil.
	e skinManager uninstallSkinIn: e.
	self assert: e skinManager installedSkin isNil
]
