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
	e skinManager setDefaultSkin: (sk := ToRawSkin new) in: e.
	self assert: e skinManager installedSkin isNil.
	self assert: e skinManager installedSkin isNil.
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
	self assert: e skinManager installedSkin isNil.
	e skinManager requestNewSkinIn: e.
	self assert: e skinManager skinInstaller notNil.

]

{ #category : #tests }
ToSkinManagerTest >> testApplySkinUninstallerIn [

	| e sk |
	e := ToElement new. 
	space root addChild: e.
	e skinManager uninstallSkinIn: e.
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
	e skinManager uninstallSkinIn: e.
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
	self assert: e skinManager defaultRawSkin identicalTo: sk
]

{ #category : #tests }
ToSkinManagerTest >> testDefaultRawSkinIn [

	| e sk |
	e := ToElement new.
	space root addChild: e.
	e skinManager uninstallSkinIn: e.
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
	self assert: e skinManager installedSkin notNil.
	self
		assert:
			(e eventDispatcher handlers select: [ :h | h isKindOf: ToRawSkin ])
				size
		equals: 1
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
	self assert: e skinManager skinInstaller notNil
]

{ #category : #tests }
ToSkinManagerTest >> testForceDefaultSkinInWhenInSpace [

	| e sk |
	e := ToElement new.
	space root addChild: e.
	e skinManager uninstallSkinIn: e.
	e skinManager setDefaultSkin: (sk := ToRawSkin new) in: e.
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: e skinManager installedSkin isNil.
	self deny: e skinManager skinUninstaller notNil.
	self assert: e skinManager skinInstaller notNil
]

{ #category : #tests }
ToSkinManagerTest >> testInstallSkinIn [

	| e skin |
	e := ToElement new.
	space root addChild: e.

	skin := ToRawSkin new.
	"e skinManager installSkin: skin in: e."
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
	e skinManager uninstallSkinIn: e.
	e skinManager installSkin: (e skinManager skinToInstallIn: e) in: e.
	self assert:
		(e skinManager installedSkin) notNil.
	self
		assert: (e skinManager installedSkin) class
		equals: (e lookupTheme newSkinFor: e) class
]

{ #category : #tests }
ToSkinManagerTest >> testInstallSkinInError [

	| e skin |
	e := ToElement new.
	skin := ToRawSkin new.
	" an error is raised because the element is not attached "
	self should: [ e skinManager installSkin: skin in: e ] raise: Error.

	space root addChild: e.
	self should: [ e skinManager installSkin: skin in: e ] raise: Error.
	e skinManager uninstallSkinIn: e.
	e skinManager installSkin: skin in: e.
	self assert: e skinManager installedSkin notNil
]

{ #category : #tests }
ToSkinManagerTest >> testInstalledSkin [

	| e sk |
	e := ToElement new.
	space root addChild: e.
	e defaultSkin: (sk := ToRawSkin new).
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: e skinManager installedSkin notNil.
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
	self assert: e skinManager installedSkin notNil
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
	self assert:
		(e skinManager installedSkin) isNil.
	self deny: e skinManager skinUninstaller notNil.

	" requestSkin has not effect on skinUninstaller "
	e skinManager requestInstallSkinIn: e.
	self assert:
		(e skinManager installedSkin) isNil.
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
	self assert: e skinManager installedSkin notNil.
	self assert: e skinManager skinInstaller isNil.
	self assert: child skinManager installedSkin notNil.
	self assert: child skinManager skinInstaller isNil.
	self assert: childchild skinManager installedSkin notNil.
	self assert: childchild skinManager skinInstaller isNil.

	e skinManager requestUninstallSkinIn: e.
	self assert: e skinManager skinUninstaller notNil.
	" but installed skin not yet uninstalled "
	self assert: e skinManager installedSkin notNil.

	" uninstalling "
	e skinManager applySkinUninstallerIn: e.
	self assert: e skinManager installedSkin isNil.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller isNil.

	" but no effect on children "
	self assert: child skinManager installedSkin notNil.
	self assert: childchild skinManager installedSkin notNil.

	e skinManager applySkinInstallerIn: e.
	self assert: e skinManager installedSkin isNil.
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

	" trying to install here should not results in an installed skin because no installer has been requested "
	e skinManager applySkinReinstallIn: e.
	self assert: e skinManager installedSkin isNil.

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
	self assert: e skinManager installedSkin notNil.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller isNil
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
	self assert: e skinManager installedSkin notNil.
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
		(e skinManager installedSkin) notNil.
	self assert: e skinManager skinUninstaller notNil.
	self assert:
		(child skinManager installedSkin) notNil.
	self assert: child skinManager skinUninstaller notNil.
	self assert:
		(childchild skinManager installedSkin) notNil.
	self assert: childchild skinManager skinUninstaller notNil
]

{ #category : #tests }
ToSkinManagerTest >> testStyleSheet [

	self testSetStyleSheetIn 
]

{ #category : #tests }
ToSkinManagerTest >> testTextAttributesBuilderIn [

	| e |
	e := ToElement new.
	e skinManagerDo: [ :skm | skm ensureHaveSkinContext ].
	self assert: e textAttributesBuilder notNil
]

{ #category : #tests }
ToSkinManagerTest >> testUninstallSkinIn [

	| e skin |
	e := ToElement new.
	space root addChild: e.
	skin := ToRawSkin new.
	e skinManager uninstallSkinIn: e.
	self assert: e skinManager installedSkin isNil.
	e skinManager installSkin: skin in: e.
	self assert: e skinManager installedSkin notNil.
	e skinManager uninstallSkinIn: e.
	self assert: e skinManager installedSkin isNil
]
