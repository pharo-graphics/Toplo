Class {
	#name : 'ToSpaceSkinStateApplicationPhaseTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-SpaceFrame',
	#package : 'Toplo-Tests',
	#tag : 'Core-SpaceFrame'
}

{ #category : 'running' }
ToSpaceSkinStateApplicationPhaseTest >> setUp [
	super setUp.
	space := self newTestingSpace 
]

{ #category : 'tests' }
ToSpaceSkinStateApplicationPhaseTest >> testStartSkinPhases [

	| nb |
	nb := space frame phases size.

	" before the element is added in space, its space frame phases remain unchanged "
	self assert: (space frame phases noneSatisfy: [ :p |
			 p isKindOf: ToSpaceSkinInstallerPhase ]).
	self assert: (space frame phases noneSatisfy: [ :p |
			 p isKindOf: ToSpaceSkinStateApplicationPhase ]).

	" shoud result in a requestSkin which do the installation if needed "
	" The skin specific phase is added"
	space when: ToSpaceSkinPhasesStarted doOnce: [
		self assert: space frame phases size equals: nb + 2.
		self assert: (space frame phases anySatisfy: [ :p |
				 p isKindOf: ToSpaceSkinInstallerPhase ]).
		self assert: (space frame phases anySatisfy: [ :p |
				 p isKindOf: ToSpaceSkinStateApplicationPhase ]).
		space close ].
	
	space skinPhasesManager startSkinPhasesIn: space


]

{ #category : 'tests' }
ToSpaceSkinStateApplicationPhaseTest >> testStartStopSkinStatePhases [

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
				 p isKindOf: ToSpaceSkinStateApplicationPhase ]) ].
		
	space startSkinPhases.
	self assert: started.

	stopped := false.
	space when: ToSpaceSkinPhasesStopped doOnce: [
		stopped := true.
		" The skin specific phase is removed "
		self assert: space frame phases size equals: nb.
		self assert: (space frame phases noneSatisfy: [ :p |
				 p isKindOf: ToSpaceSkinStateApplicationPhase ]).
		self assert: (space frame phases noneSatisfy: [ :p |
				 p isKindOf: ToSpaceSkinInstallerPhase ]) ].

	space stopSkinPhases.
	self assert: stopped
]
