Class {
	#name : #ToSpaceSkinStateApplicationPhaseTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-SpaceFrame'
}

{ #category : #tests }
ToSpaceSkinStateApplicationPhaseTest >> testStartSkinPhases [

	" before the element is added in space, its space frame phases remain unchanged "
	self assert: (space frame phases anySatisfy: [ :p |
			 p isKindOf: ToSpaceSkinInstallerPhase ]).
	self assert: (space frame phases anySatisfy: [ :p |
			 p isKindOf: ToSpaceSkinStateApplicationPhase ])
]

{ #category : #tests }
ToSpaceSkinStateApplicationPhaseTest >> testStartStopSkinStatePhases [

	| nb stopped |
	nb := space frame phases size.
	stopped := false.
	space addEventHandlerOn: ToSpacePhasesStopped doOnce: [
		stopped := true.
		" The skin specific phase is removed "
		self assert: space frame phases size equals: nb - 3.
		self assert: (space frame phases noneSatisfy: [ :p |
				 p isKindOf: ToSpaceSkinStateApplicationPhase ]).
		self assert: (space frame phases noneSatisfy: [ :p |
				 p isKindOf: ToSpaceSkinInstallerPhase ]) ].

	space stopToploPhases.
	self assert: stopped
]
