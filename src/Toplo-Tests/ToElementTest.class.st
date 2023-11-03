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

{ #category : 'tests' }
ToElementTest >> testAddEventFilter [

	| e count |
	e := ToElement new.
	self deny: (e eventDispatcher hasEventFilterSuchThat: [ :eh |
			 eh isKindOf: ToSkinStateGenerator ]).
	e addEventFilter: ToSkinStateGenerator new.
	count := 0.
	self assert: (e eventDispatcher hasEventFilterSuchThat: [ :eh |
			 (eh isKindOf: ToSkinStateGenerator)
				 ifTrue: [
					 count := count + 1.
					 true ]
				 ifFalse: [ false ] ]).
	self assert: count equals: 1.
	self
		should: [ e addEventFilter: ToSkinStateGenerator new ]
		raise: Error
]

{ #category : 'tests' }
ToElementTest >> testAddEventHandler [

	| e count |
	e := ToElement new.
	self deny: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToSkinStateGenerator ]).
	e addEventHandler: ToSkinStateGenerator new.
	count := 0.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 (eh isKindOf: ToSkinStateGenerator)
				 ifTrue: [
					 count := count + 1.
					 true ]
				 ifFalse: [ false ] ]).
	self assert: count equals: 1.
	self
		should: [ e addEventHandler: ToSkinStateGenerator new ]
		raise: Error
]

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

{ #category : 'tests' }
ToElementTest >> testCheckEventFilter [

	| e |
	e := ToElement new.
	e addEventFilter: ToSkinStateGenerator new.
	self
		should: [ e checkEventFilter: ToSkinStateGenerator new ]
		raise: Error.
	e := ToElement new.
	e addEventFilter: ToSkinStateGenerator new.
	e checkEventHandler: ToSkinStateGenerator new
]

{ #category : 'tests' }
ToElementTest >> testCheckEventHandler [

	| e |
	e := ToElement new.
	e addEventHandler: ToSkinStateGenerator new.
	self
		should: [ e checkEventHandler: ToSkinStateGenerator new ]
		raise: Error.
		e := ToElement new.
	e addEventFilter: ToSkinStateGenerator new.
	e checkEventHandler: ToSkinStateGenerator new
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
ToElementTest >> testWithoutSkinNonContamination [

	" NullSkin is not contaminant: check if children are not impacted "

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
	self deny: child defaultSkin isNullSkin.
	self deny: childchild defaultSkin isNullSkin.
	
	e applySkinInstaller.
	child applySkinInstaller.
	childchild applySkinInstaller.
	
	self assert: e skinInstaller isNil.
	self assert: e installedSkin  isNullSkin.
	self assert: child skinInstaller isNil.
	self assert: child installedSkin isNil.
	self assert: childchild skinInstaller isNil.
	self assert: childchild installedSkin isNil
]

{ #category : 'test initialize' }
ToElementTest >> testWithoutSkinNonContamination2 [

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
	child applySkinInstaller.
	childchild applySkinInstaller.
	self assert: child skinInstaller isNil.
	self assert: child installedSkin  isNil.
	self assert: childchild skinInstaller isNil.
	self assert: childchild installedSkin  isNil
]
