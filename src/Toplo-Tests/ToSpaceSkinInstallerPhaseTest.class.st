"
A ToSpaceSkinInstallerPhaseTest is a test class for testing the behavior of ToSpaceSkinInstallerPhase
"
Class {
	#name : #ToSpaceSkinInstallerPhaseTest,
	#superclass : #TestCase,
	#category : 'Toplo-Tests-Core-SpaceFrame'
}

{ #category : #tests }
ToSpaceSkinInstallerPhaseTest >> testElementAddedToSceneGraphEvent [

	| space e nb |
	space := BlSpace new.
	e := ToElement new.

	" the element has the specific event handler to check phase installation"
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToSpaceSkinInstallerPhaseCheckerEventHandler ]).

	nb := space frame phases size.
	" before the element is added in space, its space frame phases remain unchanged "
	self assert: (space frame phases noneSatisfy: [ :p |
			 p isKindOf: ToSpaceSkinInstallerPhase ]).
	self assert: (space frame phases noneSatisfy: [ :p |
			 p isKindOf: ToSpaceSkinStatePhase ]).
		
	space root addChild: e.

	" The skin specific phase is added"
	self assert: space frame phases size equals: nb + 2.
	self assert: (space frame phases anySatisfy: [ :p |
			 p isKindOf: ToSpaceSkinInstallerPhase ]).
	self assert: (space frame phases anySatisfy: [ :p |
			 p isKindOf: ToSpaceSkinStatePhase ]).

	" the specific event handler to check phase installation is removed form the element event dispatcher"
	self deny: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToSpaceSkinInstallerPhaseCheckerEventHandler ])
]

{ #category : #tests }
ToSpaceSkinInstallerPhaseTest >> testStopSpaceFrameSkinInstallerPhase [

	| space e nb |
	space := BlSpace new.
	e := ToElement new.
	nb := space frame phases size.
	space root addChild: e.

	" The skin specific phase is added"
	self assert: space frame phases size equals: nb + 2.
	self assert: (space frame phases anySatisfy: [ :p |
			 p isKindOf: ToSpaceSkinInstallerPhase ]).
	self assert: (space frame phases anySatisfy: [ :p |
			 p isKindOf: ToSpaceSkinStatePhase ]).

	space stopSkinInstallerPhase.
	" The skin specific phase is removed "
	self assert: space frame phases size equals: nb + 1.
	self assert: (space frame phases noneSatisfy: [ :p |
			 p isKindOf: ToSpaceSkinInstallerPhase ]).


]
