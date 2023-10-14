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
ToElementTest >> testOnAddedToSceneGraph [

	| e |
	e := ToElement new.
	self assert: e skinInstaller isNil.
	BlSpace new root addChild: e.
	self assert: e skinInstaller notNil.
	self assert: (e skinInstaller isKindOf: ToLazySkinInstaller)
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
