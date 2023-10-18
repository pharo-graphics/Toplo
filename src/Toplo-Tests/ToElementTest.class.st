"
A ToElementTest is a test class for testing the behavior of ToElement
"
Class {
	#name : 'ToElementTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Tests-Core',
	#package : 'Toplo-Tests',
	#tag : 'Core'
}

{ #category : 'test initialize' }
ToElementTest >> testAddSkinInstallerPhaseChecker [

	| e |
	e := ToElement new.
	self
		assert: (e eventDispatcher handlers select: [ :h |
				 h class == ToSpaceSkinInstallerPhaseCheckerEventHandler ]) size
		equals: 1.
	e addSkinInstallerPhaseChecker.
	self
		assert: (e eventDispatcher handlers select: [ :h |
				 h class == ToSpaceSkinInstallerPhaseCheckerEventHandler ]) size
		equals: 1.
	e removeSkinInstallerPhaseChecker.
	self
		assert: (e eventDispatcher handlers select: [ :h |
				 h class == ToSpaceSkinInstallerPhaseCheckerEventHandler ]) size
		equals: 0.
	e addSkinInstallerPhaseChecker.
	self
		assert: (e eventDispatcher handlers select: [ :h |
				 h class == ToSpaceSkinInstallerPhaseCheckerEventHandler ]) size
		equals: 1.
	e addSkinInstallerPhaseChecker.
	self
		assert: (e eventDispatcher handlers select: [ :h |
				 h class == ToSpaceSkinInstallerPhaseCheckerEventHandler ]) size
		equals: 1
]

{ #category : 'test initialize' }
ToElementTest >> testHasSkinInstallerPhaseChecker [

	| e |
	e := ToElement new.
	self assert: e hasSkinInstallerPhaseChecker.
	BlSpace new root addChild: e.
	self deny: e hasSkinInstallerPhaseChecker
]

{ #category : 'test initialize' }
ToElementTest >> testInitialize [

	| e |
	e := ToElement new.
	self assert: e skinInstallerPhaseChecker notNil.

]

{ #category : 'test initialize' }
ToElementTest >> testOnAddedToParent [

	| e container |
	e := ToElement new.
	BlSpace new root addChild: e.
	self assert: e isEnabled.
	e := ToElement new.
	e disable.
	BlSpace new root addChild: e.
	self assert: e isDisabled.
	e := ToElement new.
	BlSpace new root
		disable;
		addChild: e.
	self assert: e isDisabled.

	container := ToElement new.
	e := ToElement new.
	BlSpace new root
		disable;
		addChild: container.
	container addChild: e.
	self assert: e isDisabled
]

{ #category : 'test initialize' }
ToElementTest >> testOnAddedToSceneGraph [

	| e |
	e := ToElement new.
	self assert: e skinInstaller isNil.
	BlSpace new root addChild: e.
	self assert: e skinInstaller notNil.
	self assert: (e skinInstaller isKindOf: ToSkinInstaller)
]

{ #category : 'test initialize' }
ToElementTest >> testRemoveSkinInstallerPhaseChecker [

	| e |
	e := ToElement new.
	self
		assert: (e eventDispatcher handlers select: [ :h |
				 h class == ToSpaceSkinInstallerPhaseCheckerEventHandler ]) size
		equals: 1.
	e removeSkinInstallerPhaseChecker.
	self
		assert: (e eventDispatcher handlers select: [ :h |
				 h class == ToSpaceSkinInstallerPhaseCheckerEventHandler ]) size
		equals: 0
]

{ #category : 'test initialize' }
ToElementTest >> testSkinInstallerPhaseChecker [

	| e |
	e := ToElement new.
	self assert: e skinInstallerPhaseChecker notNil.
	self
		assert: e skinInstallerPhaseChecker class
		identicalTo: ToSpaceSkinInstallerPhaseCheckerEventHandler.
	self assert: (e eventDispatcher handlers anySatisfy: [ :h |
			 h class == ToSpaceSkinInstallerPhaseCheckerEventHandler ]).
	BlSpace new root addChild: e.
	self assert: e skinInstallerPhaseChecker isNil
]

{ #category : 'test initialize' }
ToElementTest >> testWithoutSkin [

	| e |
	e := ToElement new.
	e requestSkin.
	self assert: e skinInstaller notNil.
	self assert: (e skinInstaller isKindOf: ToSkinInstaller).
	e withoutSkin.
	self assert: e defaultSkin isNullSkin.
	e applySkinInstaller.
	self assert: e skinInstaller isNil.
	self assert: e installedSkin  isNullSkin
]

{ #category : 'test initialize' }
ToElementTest >> testWithoutSkinContamination [

	" NullSkin is contaminant: check if children are correctly impacted (withoutSkin must be applied recursively)"

	| e child childchild |
	
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	child addChild: childchild.
	e addChild: child.
	e requestSkin.
	e withoutSkin.
	" withoutSkin must be applied to the element hierarchy "
	self assert: e defaultSkin isNullSkin.
	self assert: child defaultSkin isNullSkin.
	self assert: childchild defaultSkin isNullSkin.
	e applySkinInstaller.
	self assert: e skinInstaller isNil.
	self assert: e installedSkin  isNullSkin.
	self assert: child skinInstaller isNil.
	self assert: child installedSkin  isNullSkin.
	self assert: childchild skinInstaller isNil.
	self assert: childchild installedSkin  isNullSkin
]

{ #category : 'test initialize' }
ToElementTest >> testWithoutSkinContamination2 [

	" check if children are correctly impacted when they are added as child of their parent 
	(withoutSkin must be applied when a child is added )"

	| e child childchild |
	e := ToElement new.
	child := ToElement new.
	childchild := ToElement new.
	child addChild: childchild.
	e requestSkin.
	e withoutSkin.
	self assert: e defaultSkin isNullSkin.
	self assert: child installedSkin isNil.
	self assert: childchild installedSkin isNil.
	e applySkinInstaller.
	self assert: e skinInstaller isNil.
	self assert: e installedSkin isNullSkin.
	e addChild: child.
	e applySkinInstaller.
	self assert: child skinInstaller isNil.
	self assert: child installedSkin  isNullSkin.
	self assert: childchild skinInstaller isNil.
	self assert: childchild installedSkin  isNullSkin
]
