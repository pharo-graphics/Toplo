Class {
	#name : #ToSpaceSkinStatePhaseTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-SpaceFrame'
}

{ #category : #running }
ToSpaceSkinStatePhaseTest >> setUp [
	super setUp.
	space := self newTestingSpace 
]

{ #category : #tests }
ToSpaceSkinStatePhaseTest >> testStartSkinPhases [

	| nb |
	nb := space frame phases size.

	" before the element is added in space, its space frame phases remain unchanged "
	self assert: (space frame phases noneSatisfy: [ :p |
			 p isKindOf: ToSpaceSkinInstallerPhase ]).
	self assert: (space frame phases noneSatisfy: [ :p |
			 p isKindOf: ToSpaceSkinStatePhase ]).

	" shoud result in a requestSkin which do the installation if needed "
	" The skin specific phase is added"
	space when: ToSpaceSkinPhasesStarted doOnce: [
		self assert: space frame phases size equals: nb + 2.
		self assert: (space frame phases anySatisfy: [ :p |
				 p isKindOf: ToSpaceSkinInstallerPhase ]).
		self assert: (space frame phases anySatisfy: [ :p |
				 p isKindOf: ToSpaceSkinStatePhase ]).
		space close ].
	
	space skinPhasesManager onInstalledIn: space


]

{ #category : #tests }
ToSpaceSkinStatePhaseTest >> testStartStopSkinStatePhases [

	| nb stopped started |
	nb := space frame phases size.

	started := false.

	space when: ToSpaceSkinPhasesStarted doOnce: [
		started := true.
		" The skin specific phase is added"
		self assert: space frame phases size equals: nb + 2.
		self assert: (space frame phases anySatisfy: [ :p |
				 p isKindOf: ToSpaceSkinInstallerPhase ]).
		self assert: (space frame phases anySatisfy: [ :p |
				 p isKindOf: ToSpaceSkinStatePhase ]) ].
		
	space startSkinPhases.
	self assert: started.

	stopped := false.
	space when: ToSpaceSkinPhasesStopped doOnce: [
		stopped := true.
		" The skin specific phase is removed "
		self assert: space frame phases size equals: nb.
		self assert: (space frame phases noneSatisfy: [ :p |
				 p isKindOf: ToSpaceSkinStatePhase ]).
		self assert: (space frame phases noneSatisfy: [ :p |
				 p isKindOf: ToSpaceSkinInstallerPhase ]) ].

	space stopSkinPhases.
	self assert: stopped
]
