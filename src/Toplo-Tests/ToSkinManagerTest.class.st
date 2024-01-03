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
	e skinManager setSkin: (sk := ToRawSkin new) in: e.
	self assert: e installedSkin isNil.
	self assert: e skinManager installedSkin isNil.
	self assert: e skinManager hasPostponedRequestInstallSkin not.
	self assert: e skinManager skinInstaller notNil.
	e skinManager applySkinInstallerIn: e.
	self assert: e skinManager installedSkin identicalTo: sk.
	self assert: e skinManager skinInstaller isNil.

]

{ #category : #tests }
ToSkinManagerTest >> testApplySkinInstallerIn2 [

	| e |
	e := ToElement new.
	" no skinInstaller -> error "
	self should: [e skinManager applySkinInstallerIn: e ] raise: Error.
	e requestNewSkin.
	self assert: e skinManager hasPostponedRequestInstallSkin.

	
	

]

{ #category : #tests }
ToSkinManagerTest >> testApplySkinUninstallerIn [

	| e sk |
	e := ToElement new. 
	space root addChild: e.
	e skinManager setSkin: (sk := ToRawSkin new) in: e.
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
	e skinManager setSkin: (sk := ToRawSkin new) in: e.
	e skinManager applySkinInstallerIn: e.
	self assert: e skinManager installedSkin identicalTo: sk.
	self assert: e skinManager skinStateQueue nextStates isEmpty.

]

{ #category : #tests }
ToSkinManagerTest >> testBorderBuilder [

	| e  |
	e := BlElement new.
	self assert: (e skinManager borderBuilder ) notNil
]

{ #category : #tests }
ToSkinManagerTest >> testDefaultSkinIn [

	| e sk |
	e := ToElement new.
	space root addChild: e.
	e defaultSkin: (sk := ToRawSkin new).
	self assert: e defaultSkin identicalTo: sk.
	self assert: (e skinManager defaultSkinIn: e) identicalTo: sk.
	self assert: e installedSkin isNil.
	self assert: e skinManager installedSkin isNil.
	self
		assert: (e eventDispatcher handlers select: [ :h | h isKindOf: ToRawSkin ]) size
		equals: 0
]

{ #category : #tests }
ToSkinManagerTest >> testHasPostponedRequestInstallSkin [

	| e handlersNb |
	e := ToElement new.
	self assert: e skinManager hasPostponedRequestInstallSkin not.
	handlersNb := e eventDispatcher handlers size.
	e skinManager postponeRequestSkinIn: e.
	self assert: e skinManager hasPostponedRequestInstallSkin.
	self
		assert: e eventDispatcher handlers size
		equals: handlersNb + 1.
	self assert: e skinManager skinInstaller isNil.
	
	" the postpone action is runned when BlElementAddedToSceneGraph is sent "	
	space root addChild: e.
	self assert: e skinManager hasPostponedRequestInstallSkin not.
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
	self assert: e installedSkin isNil.
	" if not theme is found in its parent chain, then an element must be attached to a space. 
	If not, skin installation raises an Error because during skin installation the element theme is lookup "
	space root addChild: e.
	e skinManager installSkin: e defaultSkin in: e.
	self assert: e installedSkin notNil.
	self
		assert: e installedSkin class
		equals: (e toTheme newSkinFor: e) class
]

{ #category : #tests }
ToSkinManagerTest >> testInstalledSkin [

	| e sk |
	e := ToElement new.
	space root addChild: e.
	e defaultSkin: (sk := ToRawSkin new).
	self assert: e defaultSkin identicalTo: sk.
	self assert: (e skinManager defaultSkinIn: e) identicalTo: sk.
	self assert: e installedSkin isNil.
	self assert: e skinManager installedSkin isNil.
	e addEventHandler: sk.
	self assert: e defaultSkin identicalTo: sk.
	self assert: (e skinManager defaultSkinIn: e) identicalTo: sk.
	self assert: e installedSkin identicalTo: sk.
	self assert: e skinManager installedSkin identicalTo: sk.
	self
		assert: (e eventDispatcher handlers select: [ :h | h isKindOf: ToRawSkin ]) size
		equals: 1.
	e removeEventHandler: sk.
	self assert: e defaultSkin identicalTo: sk.
	self assert: (e skinManager defaultSkinIn: e) identicalTo: sk.
	self assert: e installedSkin isNil.
	self assert: e skinManager installedSkin isNil.
	self
		assert: (e eventDispatcher handlers select: [ :h | h isKindOf: ToRawSkin ]) size
		equals: 0
]

{ #category : #tests }
ToSkinManagerTest >> testInstalledSkinDo [

	| e sk cpt |
	cpt := 0.
	e := ToElement new. 
	e defaultSkin: (sk := ToRawSkin new).
	e installedSkinDo: [ :s | cpt := cpt + 1 ].
	self assert: cpt isZero.
	e addEventHandler: sk.
	e installedSkinDo: [ :s | cpt := cpt + 1 ].
	self assert: cpt equals: 1.
	e removeEventHandler: sk.
	e installedSkinDo: [ :s | cpt := cpt + 1 ].
	self assert: cpt equals: 1.

]

{ #category : #tests }
ToSkinManagerTest >> testIsRequestSkinPostponed [

	| e |
	e := ToElement new.
	self assert: e skinManager hasPostponedRequestInstallSkin not.
	e skinManager requestInstallSkinIn: e.
	" since the element is not attached to a space, the request skin is postponed "
	self assert: e skinManager hasPostponedRequestInstallSkin.
	self assert: e skinManager skinInstaller isNil

]

{ #category : #tests }
ToSkinManagerTest >> testIsRequestSkinPostponed2 [

	| e |
	e := ToElement new.
	self assert: e skinManager hasPostponedRequestInstallSkin not.
	space root addChild: e.
	" since the element is attached to a space, no request skin postponed "
	self assert: e skinManager hasPostponedRequestInstallSkin not.
	self assert: e skinManager skinInstaller notNil

]

{ #category : #tests }
ToSkinManagerTest >> testIsSetUpForTheme [

	| e theme skin |
	e := BlElement new.
	space := BlSpace new.
	theme := ToRawTheme light.
	self deny: (e skinManager isSetUpForTheme: theme).
	self assert: e skinManager themeClasses isEmpty.
	self assert: ((theme newSkinFor: e) isKindOf: ToRawSkin).
	space root addChild: e.
	skin := theme newSkinFor: e.
	self assert: e skinManager themeClasses size equals: 1.
	self assert: e skinManager themeClasses anyOne equals: ToRawTheme
]

{ #category : #tests }
ToSkinManagerTest >> testOnInstalledIn [

	| e |
	e := BlElement new.
	self assert: e skinManager themeClasses notNil.
	self assert: e skinManager themeClasses isEmpty.
	self deny: e skinManager hasPostponedRequestInstallSkin.
	self assert: e skinInstaller isNil.
	e toStyleStore tokenPropertyIndex changedAction value.
	self assert: e skinManager hasPostponedRequestInstallSkin.
	self assert: e skinInstaller isNil
]

{ #category : #tests }
ToSkinManagerTest >> testPostponeRequestSkinIn [

	| e handlersNb |
	e := ToElement new.
	self assert: e skinManager hasPostponedRequestInstallSkin not.
	handlersNb := e eventDispatcher handlers size.
	e skinManager postponeRequestSkinIn: e.
	self assert: e skinManager hasPostponedRequestInstallSkin.
	self
		assert: e eventDispatcher handlers size
		equals: handlersNb + 1.
	self assert: e skinManager skinInstaller isNil.
	
	" the postpone action is runned when BlElementAddedToSceneGraph is sent "	
	space root addChild: e.
	self assert: e skinManager hasPostponedRequestInstallSkin not.
	self
		assert: e eventDispatcher handlers size
		equals: handlersNb.
	self assert: e skinManager skinInstaller notNil

	

]

{ #category : #tests }
ToSkinManagerTest >> testRegisterTheme [

	| e |
	e := BlElement new.
	self assert: e skinManager themeClasses notNil.
	self assert: e skinManager themeClasses isEmpty.
	e skinManager registerTheme: ToRawTheme light.
	self assert: e skinManager themeClasses size equals: 1.
	self assert: e skinManager themeClasses anyOne = ToRawTheme
]

{ #category : #tests }
ToSkinManagerTest >> testRequestInstaallSkinInWithChildren [

	| e child childchild |
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	e addChild: child.
	child addChild: childchild.
	self assert: e skinManager hasPostponedRequestInstallSkin not.
	e skinManager requestInstallSkinIn: e.
	" the requestSkin is postpone since the element is not attached "
	self assert: e skinManager hasPostponedRequestInstallSkin.
	self assert: child skinManager hasPostponedRequestInstallSkin not.
	self assert: childchild skinManager hasPostponedRequestInstallSkin not.

]

{ #category : #tests }
ToSkinManagerTest >> testRequestInstallSkinIn [

	| e  |
	e := ToElement new.
	self assert: e skinManager hasPostponedRequestInstallSkin not.
	e skinManager requestInstallSkinIn: e.
	" the requestSkin is postpone since the element is not attached "
	self assert: e skinManager hasPostponedRequestInstallSkin.

]

{ #category : #tests }
ToSkinManagerTest >> testRequestInstallSkinInWhenInSpace [

	| e  |
	e := ToElement new.
	space root addChild: e.
	" the requestSkin is not postpone since the element is attached "
	self assert: e skinManager hasPostponedRequestInstallSkin not.
	self assert: e skinInstaller notNil

]

{ #category : #tests }
ToSkinManagerTest >> testRequestSkinInWithChildrenWhenInSpace [

	| e child childchild |
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	e addChild: child.
	child addChild: childchild.
	self assert: e skinManager hasPostponedRequestInstallSkin not.
	space root addChild: e.
	" the skinInstalled is added also on children "
	self assert: e skinManager skinInstaller notNil.
	self assert: child skinManager skinInstaller notNil.
	self assert: childchild skinManager skinInstaller notNil.

]

{ #category : #tests }
ToSkinManagerTest >> testRequestUninstallSkinIn [

	| e  |
	e := ToElement new.
	e skinManager requestUninstallSkinIn: e.
	self assert: e installedSkin isNil.
	self deny: e skinManager skinUninstaller notNil.
	
	" requestSkin has not effect on skinUninstaller "
	e skinManager requestInstallSkinIn: e.
	self assert: e installedSkin isNil.
	self deny: e skinManager skinUninstaller notNil.
	self assert: e skinManager hasPostponedRequestInstallSkin.
	self assert: e skinManager skinInstaller isNil.

	" uninstalling has not effect on skin installer"
	e skinManager applySkinUninstallerIn: e .
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller isNil.
	self assert: e skinManager hasPostponedRequestInstallSkin.


	

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
	e applySkinInstallerRecursively.
	self assert: e installedSkin notNil.
	self assert: e skinManager skinInstaller isNil.
	self assert: child installedSkin notNil.
	self assert: child skinManager skinInstaller isNil.
	self assert: childchild installedSkin notNil.
	self assert: childchild skinManager skinInstaller isNil.

	e skinManager requestUninstallSkinIn: e.
	self assert: e skinManager skinUninstaller notNil.
	" but installed skin not yet uninstalled "
	self assert: e installedSkin notNil.

	" uninstalling "
	e skinManager applySkinUninstallerIn: e.
	self assert: e skinManager installedSkin isNil.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller isNil.

	" but no effect on children "
	self assert: child skinManager installedSkin notNil.
	self assert: childchild skinManager installedSkin notNil.
	
	self should: [e skinManager applySkinInstallerIn: e] raise: Error.
	e requestInstallSkin.
	e skinManager applySkinInstallerIn: e.
	self assert: e skinManager installedSkin notNil.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller isNil.

	

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
	e applySkinInstallerRecursively.
	self assert: e installedSkin notNil.
	self assert: e skinManager skinInstaller isNil.
	self assert: child installedSkin notNil.
	self assert: child skinManager skinInstaller isNil.
	self assert: childchild installedSkin notNil.
	self assert: childchild skinManager skinInstaller isNil.

	e skinManager requestUninstallSkinIn: e.
	
	self assert: e skinManager skinUninstaller notNil.
	self assert: child skinManager skinUninstaller isNil.
	self assert: childchild skinManager skinUninstaller isNil.
	" but installed skin not yet uninstalled "
	self assert: e installedSkin notNil.
	self assert: child installedSkin notNil.
	self assert: childchild installedSkin notNil.

	e skinManager applySkinUninstallerIn: e.
	self assert: e skinManager installedSkin isNil.
	
	" trying to install here should raise an error because no installer has been requested "
	self should: [ e applySkinInstaller ] raise: Error.
	
	self assert: child installedSkin notNil.
	self assert: childchild installedSkin notNil.


]

{ #category : #tests }
ToSkinManagerTest >> testRequestUninstallSkinInWithInstalledSkin [

	| e |
	e := ToElement new.
	" to ensure that the element has an installed skin "
	space root addChild: e.
	e applySkinInstaller.
	self assert: e installedSkin notNil.
	self assert: e skinManager skinInstaller isNil.

	e skinManager requestUninstallSkinIn: e.
	self assert: e skinManager skinUninstaller notNil.
	" but installed skin not yet uninstalled "
	self assert: e installedSkin notNil.

	" uninstalling "
	e skinManager applySkinUninstallerIn: e.
	self assert: e skinManager installedSkin isNil.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller isNil.

]

{ #category : #tests }
ToSkinManagerTest >> testSetSkinIn [

	| e sk |
	e := ToElement new. 
	e skinManager setSkin: (sk := ToRawSkin new) in: e.
	self assert: e skinManager expectedDefaultSkin identicalTo: sk.
	self should: [ e skinManager defaultSkinIn: e ] raise: Error.
	self assert: e installedSkin isNil.
	self assert: e skinManager installedSkin isNil.
	self deny: e skinManager skinUninstaller notNil.
	self assert: e skinManager hasPostponedRequestInstallSkin.
	self assert: e skinManager skinInstaller isNil
]

{ #category : #tests }
ToSkinManagerTest >> testSetSkinInWhenInSpace [

	| e sk |
	e := ToElement new. 
	space root addChild: e.
	e skinManager setSkin: (sk := ToRawSkin new) in: e.
	self assert: e defaultSkin identicalTo: sk.
	self assert: (e skinManager defaultSkinIn: e) identicalTo: sk.
	self assert: e installedSkin isNil.
	self assert: e skinManager installedSkin isNil.
	self deny: e skinManager skinUninstaller notNil.
	self assert: e skinManager hasPostponedRequestInstallSkin not.
	self assert: e skinManager skinInstaller notNil
]

{ #category : #tests }
ToSkinManagerTest >> testSetUpForThemeIn [

	| e theme  |
	e := BlElement new.
	self assert: e skinManager themeClasses notNil.
	self assert: e skinManager themeClasses isEmpty.
	theme := ToRawTheme light.
	self deny: (e skinManager isSetUpForTheme: theme).
	e skinManager setUpForTheme: theme in: e.
	self assert: (e skinManager isSetUpForTheme: theme).
	self assert: e skinManager themeClasses size equals: 1.
	self assert: e skinManager themeClasses anyOne = ToRawTheme.
	e skinManager setUpForTheme: ToRawTheme light in: e.
	self assert: e skinManager themeClasses size equals: 1.
	self assert: e skinManager themeClasses anyOne = ToRawTheme.

]

{ #category : #tests }
ToSkinManagerTest >> testSetUpForThemeIn2 [

	| e theme skin |
	e := BlElement new.
	space := BlSpace new.
	self assert: e skinManager themeClasses notNil.
	self assert: e skinManager themeClasses isEmpty.
	theme := ToRawTheme light.
	space root addChild: e.
	skin := theme newSkinFor: e.
	self assert: e skinManager themeClasses size equals: 1.
	self assert: e skinManager themeClasses anyOne = ToRawTheme
]

{ #category : #tests }
ToSkinManagerTest >> testSkinInstaller [

	| e child childchild |
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	e addChild: child.
	child addChild: childchild.
	
	self assert: e skinInstaller isNil.
	self assert: child skinInstaller isNil.
	self assert: childchild skinInstaller isNil.
	
	space root addChild: e.
	self assert: e skinInstaller notNil.
	self assert: child skinInstaller notNil.
	self assert: childchild skinInstaller notNil
]

{ #category : #tests }
ToSkinManagerTest >> testSkinInstaller2 [

	| e child childchild |
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	e addChild: child.
	child addChild: childchild.
	
	self assert: e skinInstaller isNil.
	self assert: child skinInstaller isNil.
	self assert: childchild skinInstaller isNil.
	
	e requestInstallSkin.
	self assert: e skinInstaller isNil.
	self assert: e skinManager hasPostponedRequestInstallSkin.

]

{ #category : #tests }
ToSkinManagerTest >> testSkinStateQueue [

	| e |
	e := ToElement new.
	self assert: e skinStateQueue notNil	

]

{ #category : #tests }
ToSkinManagerTest >> testSkinUninstaller [

	| e child childchild |
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	e addChild: child.
	child addChild: childchild.
	
	self assert: e skinUninstaller isNil.
	self assert: child skinUninstaller isNil.
	self assert: childchild skinUninstaller isNil.
	
	space root addChild: e.
	self assert: e skinInstaller notNil.
	self assert: e skinUninstaller isNil.
	" child skinInstaller is set explicitely with requestUninstallSkin "
	self assert: child skinUninstaller isNil.
	self assert: childchild skinUninstaller isNil
]

{ #category : #tests }
ToSkinManagerTest >> testSkinUninstallerWithToThemeChanged [

	| e child childchild |
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	e addChild: child.
	child addChild: childchild.
	
	self assert: e skinUninstaller isNil.
	self assert: child skinUninstaller isNil.
	self assert: childchild skinUninstaller isNil.
	
	space root addChild: e.
	e toThemeChanged.
	self assert: e skinInstaller notNil.
	self assert: e installedSkin isNil.
	self deny: e skinUninstaller notNil.
	self assert: child installedSkin isNil.
	self deny: child skinUninstaller notNil.
	self assert: childchild installedSkin isNil.
	self deny: childchild skinUninstaller notNil.

]

{ #category : #tests }
ToSkinManagerTest >> testStyleSheet [

	self testStyleSheetIn 
]

{ #category : #tests }
ToSkinManagerTest >> testStyleSheetChainIn [

	| e child childchild childchildchild |
	e := BlElement new.
	child := BlElement new.
	childchild := BlElement new.
	childchildchild := BlElement new.
	e addChild: child.
	child addChild: childchild.
	childchild addChild: childchildchild.
	" e is not attached -> # ( )"
	self
		assert:
		(childchildchild skinManager styleSheetChainIn: childchildchild)
		equals: #(  ).
	space := BlSpace new.
	space root addChild: e.
	" no styleSheet theme by default "
	self assert:
		(childchildchild skinManager styleSheetChainIn: childchildchild)
			isEmpty.
	space toTheme: ToStyleSheetTheme light.
	" one style sheet in theme by default "
	self assert:
		(childchildchild skinManager styleSheetChainIn: childchildchild)
			size equals: 1.
	childchild styleSheet: ToStyleSheet new.
	self
		assert:
		(childchildchild skinManager styleSheetChainIn: childchildchild)
			size
		equals: 2.
	e styleSheet: ToStyleSheet new.
	self
		assert:
		(childchildchild skinManager styleSheetChainIn: childchildchild)
			size
		equals: 3.
	childchild skinManager styleSheet inherits: false.
	self
		assert:
		(childchildchild skinManager styleSheetChainIn: childchildchild)
			size
		equals: 1
]

{ #category : #tests }
ToSkinManagerTest >> testStyleSheetIn [

	| e |
	e := BlElement new.
	e styleSheet: ToStyleSheet new.
	self assert: e skinManager styleSheet notNil
]

{ #category : #tests }
ToSkinManagerTest >> testTextAttributesBuilder [

	| e  |
	e := BlElement new.
	self assert: (e skinManager textAttributesBuilder ) notNil
]

{ #category : #tests }
ToSkinManagerTest >> testThemeClasses [

	| e |
	e := BlElement new.
	self assert: e skinManager themeClasses notNil.
	self assert: e skinManager themeClasses isEmpty.
	e skinManager setUpForTheme: ToRawTheme light in: e.
	self assert: e skinManager themeClasses size equals: 1.
	self assert: e skinManager themeClasses anyOne = ToRawTheme
]

{ #category : #tests }
ToSkinManagerTest >> testUninstallSkinIn [

	| e skin |
	e := ToElement new.
	skin := ToRawSkin new.
	e skinManager installSkin: skin in: e.
	self assert: e skinManager installedSkin notNil.
	e skinManager uninstallSkin: skin in: e.
	self assert: e skinManager installedSkin isNil
]
