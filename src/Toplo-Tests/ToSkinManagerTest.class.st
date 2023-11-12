"
A ToThemeManagerTest is a test class for testing the behavior of ToThemeManager
"
Class {
	#name : #ToSkinManagerTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-Theme'
}

{ #category : #running }
ToSkinManagerTest >> setUp [ 
	super setUp.
	space := self newTestingSpace
]

{ #category : #tests }
ToSkinManagerTest >> testApplySkinInstallerIn [

	| e sk |
	e := ToElement new. 
	space root addChild: e.
	e skinManager setSkin: (sk := ToRawSkin new) in: e.
	self assert: e installedSkin isNil.
	self assert: e skinManager installedSkin isNil.
	self assert: e skinManager isRequestSkinPostponed not.
	self assert: e skinManager skinInstaller notNil.
	e skinManager applySkinInstallerIn: e.
	self assert: e skinManager installedSkin identicalTo: sk.
	self assert: e skinManager skinInstaller isNil.

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
ToSkinManagerTest >> testDefaultSkinIn [

	| e sk |
	e := ToElement new. 
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
ToSkinManagerTest >> testInstalledSkin [

	| e sk |
	e := ToElement new. 
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
	self assert: e skinManager isRequestSkinPostponed not.
	e skinManager requestSkinIn: e.
	" since the element is not attached to a space, the request skin is postponed "
	self assert: e skinManager isRequestSkinPostponed.
	self assert: e skinManager skinInstaller isNil

]

{ #category : #tests }
ToSkinManagerTest >> testIsRequestSkinPostponed2 [

	| e |
	e := ToElement new.
	self assert: e skinManager isRequestSkinPostponed not.
	space root addChild: e.
	" since the element is attached to a space, no request skin postponed "
	self assert: e skinManager isRequestSkinPostponed not.
	self assert: e skinManager skinInstaller notNil

]

{ #category : #tests }
ToSkinManagerTest >> testLocalTheme [

	| e |
	e := ToElement new.
	self assert: e skinManager localTheme isNil.
	e localToTheme: ToRawTheme new.
	self assert: e skinManager localTheme notNil.
	self
		assert: e skinManager localTheme class
		identicalTo: ToRawTheme
]

{ #category : #tests }
ToSkinManagerTest >> testLocalThemeIn [

	| e |
	e := ToElement new.
	self assert: e skinManager localTheme isNil.
	self assert: e skinInstaller isNil.
	self assert: e skinUninstaller isNil.
	e skinManager localTheme: ToRawTheme new in: e.
	self assert: e skinManager localTheme notNil.
	self
		assert: e skinManager localTheme class
		identicalTo: ToRawTheme.
	self assert: e skinManager isRequestSkinPostponed.
	self assert: e skinInstaller isNil.
	self assert: e skinUninstaller notNil
]

{ #category : #tests }
ToSkinManagerTest >> testLocalThemeIn2 [

	| e |
	e := ToElement new.
	e addChild: ToElement new.
	self assert: e skinManager localTheme isNil.
	self assert: e skinInstaller isNil.
	self assert: e skinUninstaller isNil.
	self assert: e firstChild skinManager localTheme isNil.
	self assert: e firstChild skinInstaller isNil.
	self assert: e firstChild skinUninstaller isNil.
	e skinManager localTheme: ToRawTheme new in: e.
	self assert: e skinManager localTheme notNil.
	self
		assert: e skinManager localTheme class
		identicalTo: ToRawTheme.
	self assert: e skinManager isRequestSkinPostponed.
	self assert: e skinInstaller isNil.
	self assert: e skinUninstaller notNil.
	self assert: e firstChild skinManager localTheme isNil.
	self assert: e firstChild skinManager isRequestSkinPostponed.
	self assert: e firstChild skinInstaller isNil.
	self assert: e firstChild skinUninstaller notNil
]

{ #category : #tests }
ToSkinManagerTest >> testLookupThemeFrom [

	| e child childchild |
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	e addChild: child.
	child addChild: childchild.
	self assert: e skinManager localTheme isNil.
	" not in space and no localTheme -> lookup raises an Error "
	self should: [ e skinManager lookupThemeFrom: e ] raise: Error.
	
	space root addChild: e.
	self assert: ((e skinManager lookupThemeFrom: e) isKindOf: ToTheme).
	self assert: ((child skinManager lookupThemeFrom: child) isKindOf: ToTheme).
	self assert: ((childchild skinManager lookupThemeFrom: childchild) isKindOf: ToTheme).
	
	self assert: child skinManager localTheme isNil.
	self assert: childchild skinManager localTheme isNil
]

{ #category : #tests }
ToSkinManagerTest >> testLookupThemeFrom2 [

	| e child childchild |
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	e addChild: child.
	child addChild: childchild.
	self assert: e skinManager localTheme isNil.
	" not in space and no localTheme -> lookup raises an Error "
	self should: [ e skinManager lookupThemeFrom: e ] raise: Error.

	e skinManager localTheme: ToRawTheme new.
	
	self assert: ((e skinManager lookupThemeFrom: e) isKindOf: ToTheme).
	self assert: ((child skinManager lookupThemeFrom: child) isKindOf: ToTheme).
	self assert: ((childchild skinManager lookupThemeFrom: childchild) isKindOf: ToTheme).
	
	self assert: child skinManager localTheme isNil.
	self assert: childchild skinManager localTheme isNil
]

{ #category : #tests }
ToSkinManagerTest >> testLookupThemeFrom3 [

	| e child childchild |
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	e addChild: child.
	child addChild: childchild.
	self assert: e skinManager localTheme isNil.
	" not in space and no localTheme -> lookup raises an Error "
	self should: [ e skinManager lookupThemeFrom: e ] raise: Error.

	child skinManager localTheme: ToRawTheme new.
	
	self should: [ e skinManager lookupThemeFrom: e ] raise: Error.
	self assert: ((child skinManager lookupThemeFrom: child) isKindOf: ToTheme).
	self assert: ((childchild skinManager lookupThemeFrom: childchild) isKindOf: ToTheme).
	
	self assert: e skinManager localTheme isNil.
	self assert: childchild skinManager localTheme isNil
]

{ #category : #tests }
ToSkinManagerTest >> testPostponeRequestSkinIn [

	| e handlersNb |
	e := ToElement new.
	self assert: e skinManager isRequestSkinPostponed not.
	handlersNb := e eventDispatcher handlers size.
	e skinManager postponeRequestSkinIn: e.
	self assert: e skinManager isRequestSkinPostponed.
	self
		assert: e eventDispatcher handlers size
		equals: handlersNb + 1.
	self assert: e skinManager skinInstaller isNil.
	
	" the postpone action is runned when BlElementAddedToSceneGraph is sent "	
	space root addChild: e.
	self assert: e skinManager isRequestSkinPostponed not.
	self
		assert: e eventDispatcher handlers size
		equals: handlersNb.
	self assert: e skinManager skinInstaller notNil

	

]

{ #category : #tests }
ToSkinManagerTest >> testPostponeRequestSkinNotOnChildren [
	
	" requestSkin postpone does not impact children to preserve efficiency "

	| e child childchild handlersNb |
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	e addChild: child.
	child addChild: childchild.

	self assert: child skinManager isRequestSkinPostponed not.
	handlersNb := child eventDispatcher handlers size.
	e skinManager postponeRequestSkinIn: e.
	self assert: child skinManager isRequestSkinPostponed not.
	self assert: childchild skinManager isRequestSkinPostponed not.
	self
		assert: child eventDispatcher handlers size
		equals: handlersNb.
	self assert: child skinManager skinInstaller isNil.
	self assert: childchild skinManager skinInstaller isNil.
	space root addChild: e.
	self assert: child skinManager isRequestSkinPostponed not.
	self
		assert: child eventDispatcher handlers size
		equals: handlersNb.

	self assert: child skinManager skinInstaller notNil.
	self assert: childchild skinManager skinInstaller notNil

	

]

{ #category : #tests }
ToSkinManagerTest >> testRequestSkinIn [

	| e  |
	e := ToElement new.
	self assert: e skinManager isRequestSkinPostponed not.
	e skinManager requestSkinIn: e.
	" the requestSkin is postpone since the element is not attached "
	self assert: e skinManager isRequestSkinPostponed.

]

{ #category : #tests }
ToSkinManagerTest >> testRequestSkinInWhenInSpace [

	| e  |
	e := ToElement new.
	space root addChild: e.
	" the requestSkin is not postpone since the element is attached "
	self assert: e skinManager isRequestSkinPostponed not.
	self assert: e skinInstaller notNil

]

{ #category : #tests }
ToSkinManagerTest >> testRequestSkinInWithChildren [

	| e child childchild |
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	e addChild: child.
	child addChild: childchild.
	self assert: e skinManager isRequestSkinPostponed not.
	e skinManager requestSkinIn: e.
	" the requestSkin is postpone since the element is not attached "
	self assert: e skinManager isRequestSkinPostponed.
	self assert: child skinManager isRequestSkinPostponed not.
	self assert: childchild skinManager isRequestSkinPostponed not.

]

{ #category : #tests }
ToSkinManagerTest >> testRequestSkinInWithChildrenWhenInSpace [

	| e child childchild |
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	e addChild: child.
	child addChild: childchild.
	self assert: e skinManager isRequestSkinPostponed not.
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
	self assert: e skinManager skinUninstaller notNil.
	
	" requestSkin has not effect on skinUninstaller "
	e skinManager requestSkinIn: e.
	self assert: e skinManager skinUninstaller notNil.
	self assert: e skinManager isRequestSkinPostponed.
	self assert: e skinManager skinInstaller isNil.

	" uninstalling has not effect on skin installer"
	e skinManager applySkinUninstallerIn: e .
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller isNil.
	self assert: e skinManager isRequestSkinPostponed.


	

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
	child skinManager requestUninstallSkinIn: child.
	childchild skinManager requestUninstallSkinIn: child.
	
	self assert: e skinManager skinUninstaller notNil.
	self assert: child skinManager skinUninstaller notNil.
	self assert: childchild skinManager skinUninstaller notNil.
	" but installed skin not yet uninstalled "
	self assert: e installedSkin notNil.
	self assert: child installedSkin notNil.
	self assert: childchild installedSkin notNil.

	" install skin on the element tree: this will uninstall all installed skin "
	e applySkinInstallerRecursively.
	" skin no skinInstaller was added, no skin is installed "
	self assert: e skinManager installedSkin isNil.
	self assert: e skinManager skinUninstaller isNil.
	self assert: e skinManager skinInstaller isNil.	
	" with effect on children "
	self assert: child skinManager installedSkin isNil.
	self assert: child skinManager skinUninstaller isNil.
	self assert: child skinManager skinInstaller isNil.	
	self assert: childchild skinManager installedSkin isNil.
	self assert: childchild skinManager skinUninstaller isNil.
	self assert: childchild skinManager skinInstaller isNil.	

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
	self assert: e defaultSkin identicalTo: sk.
	self assert: (e skinManager defaultSkinIn: e) identicalTo: sk.
	self assert: e installedSkin isNil.
	self assert: e skinManager installedSkin isNil.
	self assert: e skinManager skinUninstaller notNil.
	self assert: e skinManager isRequestSkinPostponed.
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
	self assert: e skinManager skinUninstaller notNil.
	self assert: e skinManager isRequestSkinPostponed not.
	self assert: e skinManager skinInstaller notNil
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
	
	e requestSkin.
	self assert: e skinInstaller isNil.
	self assert: e skinManager isRequestSkinPostponed.

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
	self assert: e skinUninstaller notNil.
	self assert: child skinUninstaller notNil.
	self assert: childchild skinUninstaller notNil
]

{ #category : #tests }
ToSkinManagerTest >> testUpdateStylesIn [

	| e sk |
	e := ToElement new. 
	space root addChild: e.
	e skinManager setSkin: (sk := ToRawSkin new) in: e.
	e skinManager applySkinInstallerIn: e.
	self assert: e skinManager installedSkin identicalTo: sk.
	self assert: e skinManager skinStateQueue nextStates notEmpty.
	e skinManager updateStylesIn: e.
	self assert: e skinManager skinStateQueue nextStates isEmpty.

]
