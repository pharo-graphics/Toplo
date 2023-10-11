"
A ToSpaceFrameSkinInstallationPhaseTest is a test class for testing the behavior of ToSpaceFrameSkinInstallationPhase
"
Class {
	#name : #ToSpaceFrameSkinInstallationPhaseTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-SpaceFrame'
}

{ #category : #tests }
ToSpaceFrameSkinInstallationPhaseTest >> testElementAddedToSceneGraphEvent [

	| space e nb |
	space := BlSpace new.
	e := ToElement new.

	" the element has the specific event handler to check phase installation"
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToSpaceSkinInstallationPhaseCheckerEventHandler ]).

	nb := space frame phases size.
	" before the element is added in space, its space frame phases remain unchanged "
	self assert: (space frame phases noneSatisfy: [ :p |
			 p isKindOf: ToSpaceFrameSkinInstallationPhase ]).
		
	space root addChild: e.

	" The skin specific phase is added"
	self assert: space frame phases size equals: nb + 1.
	self assert: (space frame phases anySatisfy: [ :p |
			 p isKindOf: ToSpaceFrameSkinInstallationPhase ]).

	" the specific event handler to check phase installation is removed form the element event dispatcher"
	self deny: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToSpaceSkinInstallationPhaseCheckerEventHandler ])
]
