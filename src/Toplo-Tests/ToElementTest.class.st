"
A ToElementTest is a test class for testing the behavior of ToElement
"
Class {
	#name : #ToElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core'
}

{ #category : #running }
ToElementTest >> setUp [ 

	super setUp.
	space := self newTestingSpace. 

]

{ #category : #tests }
ToElementTest >> testAddEventFilter [

	| e  |
	e := ToElement new.
	self
		should: [ e addEventFilter: ToSkinStateGenerator new ]
		raise: Error
]

{ #category : #tests }
ToElementTest >> testAddEventHandler [

	| e  |
	e := ToElement new.
	self
		should: [ e addEventHandler: ToSkinStateGenerator new ]
		raise: Error
]

{ #category : #tests }
ToElementTest >> testCheckEventFilter [

	| e |
	e := ToElement new.
	e checkEventFilter: ToSkinStateGenerator new
]

{ #category : #tests }
ToElementTest >> testCheckEventHandler [

	| e |
	e := ToElement new.
	self
		should: [ e checkEventHandler: ToSkinStateGenerator new ]
		raise: Error.

]

{ #category : #'test initialize' }
ToElementTest >> testDefaultSkin [
	" check install/uninstall/initial states if defaultSkin: is used "

	| e sk sk2 |
	e := ToElement new. 
	space root addChild: e.
	e defaultSkin: (sk := ToRawSkinForTest new).
	self assert: e defaultSkin identicalTo: sk.
	self assert: e installedSkin isNil.
	e requestInstallSkin.
	" no change "
	self assert: e defaultSkin identicalTo: sk.
	self assert: e installedSkin isNil.
	self assert: sk installCpt equals: 0.
	e applySkinInstaller.
	self assert: e defaultSkin identicalTo: sk.
	self assert: e installedSkin identicalTo: sk.
	self
		assert: (e eventDispatcher handlers select: [ :h | h isKindOf: ToSkin ]) size
		equals: 1.
	self assert: sk installCpt equals: 0.
	e applyStyles.
	self assert: sk installCpt equals: 1.
	self assert: sk initialCpt equals: 1.
	self assert: sk uninstallCpt equals: 0.

	e defaultSkin: sk.
	e requestInstallSkin.
	e applySkinInstaller.
	e applyStyles.
	" no change since same skin "
	self assert: sk installCpt equals: 1.
	self assert: sk initialCpt equals: 1.
	self assert: sk uninstallCpt equals: 0.

	self
		assert: (e eventDispatcher handlers select: [ :h | h isKindOf: ToSkin ]) size
		equals: 1.

	e defaultSkin: (sk2 := ToRawSkinForTest new).
	e applySkinInstaller.
	e applyStyles.
	
	self
		assert: (e eventDispatcher handlers select: [ :h | h isKindOf: ToSkin ]) size
		equals: 1.

	self assert: sk installCpt equals: 1.
	self assert: sk initialCpt equals: 1.
	self assert: sk uninstallCpt equals: 1.
	self assert: sk2 installCpt equals: 1.
	self assert: sk2 initialCpt equals: 1.
	self assert: sk2 uninstallCpt equals: 0
]

{ #category : #'test initialize' }
ToElementTest >> testOnAddedToParent [

	| e container |
	e := ToElement new.
	space root addChild: e.
	self assert: e isEnabled.
	e := ToElement new.
	e disable.
	space root addChild: e.
	self assert: e isDisabled.
	e := ToElement new.
	space root
		disable;
		addChild: e.
	self assert: e isDisabled.

	container := ToElement new.
	e := ToElement new.
	space root
		disable;
		addChild: container.
	container addChild: e.
	self assert: e isDisabled
]

{ #category : #'test initialize' }
ToElementTest >> testOnAddedToSceneGraph [

	| e |
	e := ToElement new.
	self assert: e skinInstaller isNil.
	space root addChild: e.
	self assert: e skinInstaller notNil.
	self assert: (e skinInstaller isKindOf: ToSkinInstaller)
]

{ #category : #'test initialize' }
ToElementTest >> testPostponeRequestSkin [

	" check install/uninstall/initial states if setSkin: is used"

	| e |
	e := ToElement new.
	e requestInstallSkin.
	self assert: e skinInstaller isNil.
	self assert: e skinManager isRequestSkinPostponed.
	space root addChild: e.
	self deny: e skinManager isRequestSkinPostponed.
	self assert: e skinInstaller notNil
]

{ #category : #'test initialize' }
ToElementTest >> testRequestSkin [

	| e |
	e := ToElement new.
	self assert: e skinInstaller isNil.
	self assert: e installedSkin isNil.
	e requestInstallSkin.
	self assert: e skinInstaller isNil.
	self assert: e installedSkin isNil.
	space root addChild: e.
	self assert: e skinInstaller notNil.
	self assert: e installedSkin isNil.
	space applyAllSkinInstallers.
	self assert: e skinInstaller isNil.
	self assert: e installedSkin notNil.

]

{ #category : #'test initialize' }
ToElementTest >> testSetSkin [

	" check install/uninstall/initial states if setSkin: is used"

	| e  sk sk2 |
	e := ToElement new.
	space root addChild: e.
	e defaultSkin: (sk := ToRawSkinForTest new).
	self assert: e defaultSkin identicalTo: sk.
	self assert: e installedSkin isNil.
	e requestInstallSkin.
	" no change "
	self assert: e defaultSkin identicalTo: sk.
	self assert: e installedSkin isNil.
	self assert: sk installCpt equals: 0.
	e applySkinInstaller.
	self assert: e defaultSkin identicalTo: sk.
	self assert: e installedSkin identicalTo: sk.
	self assert: sk installCpt equals: 0.
	e applyStyles.
	self assert: sk installCpt equals: 1.
	self assert: sk initialCpt equals: 1.
	self assert: sk uninstallCpt equals: 0.
	
	self
		assert: (e eventDispatcher handlers select: [ :h | h isKindOf: ToSkin ]) size
		equals: 1.

	" force uninstall->install->initial states "
	e setSkin: sk.
	e applySkinInstaller.
	self assert: sk uninstallCpt equals: 1.
	
	e applyStyles.
	self assert: sk installCpt equals: 2.
	self assert: sk initialCpt equals: 2.
	
	self
		assert: (e eventDispatcher handlers select: [ :h | h isKindOf: ToSkin ]) size
		equals: 1.

	e defaultSkin: (sk2 := ToRawSkinForTest new).
	e applySkinInstaller.
	e applyStyles.
	
	self
		assert: (e eventDispatcher handlers select: [ :h | h isKindOf: ToSkin ]) size
		equals: 1.

	self assert: sk installCpt equals: 2.
	self assert: sk initialCpt equals: 2.
	self assert: sk uninstallCpt equals: 2.
	self assert: sk2 installCpt equals: 1.
	self assert: sk2 initialCpt equals: 1.
	self assert: sk2 uninstallCpt equals: 0.
	



]

{ #category : #'test initialize' }
ToElementTest >> testWithoutSkin [

	| e |
	e := ToElement new.
	e requestInstallSkin.
	space root addChild: e.
	self assert: e skinInstaller notNil.
	self assert: (e skinInstaller isKindOf: ToSkinInstaller).
	e applySkinInstaller.
	self
		assert: (e eventDispatcher handlers select: [ :h | h isKindOf: ToSkin ]) size
		equals: 1.

	e withoutSkin.
	self assert: e defaultSkin isNullSkin.
	
	e applySkinInstaller.
	self
		assert: (e eventDispatcher handlers select: [ :h | h isKindOf: ToSkin ]) size
		equals: 1.

	self assert: e skinInstaller isNil.
	self assert: e installedSkin  isNullSkin
]

{ #category : #'test initialize' }
ToElementTest >> testWithoutSkinNonContamination [

	" NullSkin is not contaminant: check if children are not impacted "

	| e child childchild |
	
	e := ToElement new.
	space root addChild: e.
	child := ToElement new.
	childchild := ToElement new.
	child addChild: childchild.
	e addChild: child.
	e requestInstallSkin.
	e withoutSkin.
	" withoutSkin must be applied to the element hierarchy "
	self assert: e defaultSkin isNullSkin.
	self deny: child defaultSkin isNullSkin.
	self deny: childchild defaultSkin isNullSkin.
	
	e applySkinInstallerRecursively .
	
	self assert: e skinInstaller isNil.
	self assert: e installedSkin  isNullSkin.
	self assert: child skinInstaller isNil.
	self assert: child installedSkin notNil.
	self assert: childchild skinInstaller isNil.
	self assert: childchild installedSkin notNil
]

{ #category : #'test initialize' }
ToElementTest >> testWithoutSkinNonContamination2 [

	" check if children are correctly impacted when they are added as child of their parent 
	(withoutSkin must be applied when a child is added )"

	| e child childchild |
	e := ToElement new.
	space root addChild: e.
	child := ToElement new.
	childchild := ToElement new.
	child addChild: childchild.
	e requestInstallSkin.
	e withoutSkin.
	self assert: e defaultSkin isNullSkin.
	self assert: child installedSkin isNil.
	self assert: childchild installedSkin isNil.
	e applySkinInstaller.
	self assert: e skinInstaller isNil.
	self assert: e installedSkin isNullSkin.
	e addChild: child.
	e applySkinInstallerRecursively.
	self assert: child skinInstaller isNil.
	self assert: child installedSkin  notNil.
	self assert: childchild skinInstaller isNil.
	self assert: childchild installedSkin  notNil
]
