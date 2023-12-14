"
A ToSpaceSkinPhasesManagerTest is a test class for testing the behavior of ToSpaceSkinPhasesManager
"
Class {
	#name : 'ToSpaceSkinPhasesManagerTest',
	#superclass : 'ToTestCaseWithSpace',
	#category : 'Toplo-Tests-Core-SpaceFrame',
	#package : 'Toplo-Tests',
	#tag : 'Core-SpaceFrame'
}

{ #category : 'tests' }
ToSpaceSkinPhasesManagerTest >> testAllowSkinPhases [

	| m |
	m := ToSpaceSkinPhasesManager new.
	self assert: m allowSkinPhases.
	m allowSkinPhases: false.
	self deny: m allowSkinPhases.

	
]

{ #category : 'tests' }
ToSpaceSkinPhasesManagerTest >> testCheckSkinPhasesIn [

	space checkSkinPhases.
	" since space is not opened, the skin phases installation should be postponed "
	self assert: space skinPhasesManager isSkinPhasesInstallationPostponed.
	space allowSkinPhases: false.
	space skinPhasesManager startSkinPhasesIn: space.
	self deny: space skinPhasesManager isSkinPhasesInstallationPostponed.
	self deny: space skinPhasesManager skinPhasesInstalled.

	space checkSkinPhases.
	" since skin phases are not allowed "
	self deny: space skinPhasesManager skinPhasesInstalled.
	" now allow skin phases "
	space allowSkinPhases: true.
	self assert: space skinPhasesManager isSkinPhasesInstallationPostponed.
	space skinPhasesManager startSkinPhasesIn: space.
	" since skin phases are allowed and the space is opened "
	self deny: space skinPhasesManager isSkinPhasesInstallationPostponed.
	self assert: space skinPhasesManager skinPhasesInstalled
]

{ #category : 'tests' }
ToSpaceSkinPhasesManagerTest >> testInitialize [

	| m |
	m := ToSpaceSkinPhasesManager new.
	self deny: m skinPhasesInstalled.
	self deny: m  isSkinPhasesInstallationPostponed.
	self assert: m allowSkinPhases
]

{ #category : 'tests' }
ToSpaceSkinPhasesManagerTest >> testInstalledSkinInstallerPhaseIn [

	space skinPhasesManager startSkinPhasesIn: space.
	self assert: ((space skinPhasesManager installedSkinInstallerPhaseIn: space) isKindOf: ToSpaceSkinInstallerPhase).


]

{ #category : 'tests' }
ToSpaceSkinPhasesManagerTest >> testInstalledSkinStateApplicationPhaseIn [

	space skinPhasesManager startSkinPhasesIn: space.
	self assert: ((space skinPhasesManager installedSkinStateApplicationPhaseIn: space) isKindOf: ToSpaceSkinStateApplicationPhase).
]

{ #category : 'tests' }
ToSpaceSkinPhasesManagerTest >> testIsSkinInstallerPhaseInstalledIn [

	space checkSkinPhases.
	" since space is not opened, the skin phases installation should be postponed "
	self deny: (space skinPhasesManager isSkinInstallerPhaseInstalledIn: space).
	space skinPhasesManager startSkinPhasesIn: space.
	self assert: (space skinPhasesManager isSkinInstallerPhaseInstalledIn: space).

]

{ #category : 'tests' }
ToSpaceSkinPhasesManagerTest >> testIsSkinPhasesInstallationPostponed [

	space checkSkinPhases.
	" since space is not opened, the skin phases installation should be postponed "
	self assert: (space skinPhasesManager isSkinPhasesInstallationPostponed).
	space skinPhasesManager startSkinPhasesIn: space.
	self deny: (space skinPhasesManager isSkinPhasesInstallationPostponed).



]

{ #category : 'tests' }
ToSpaceSkinPhasesManagerTest >> testIsSkinStateApplicationPhaseInstalledIn [

	space checkSkinPhases.
	" since space is not opened, the skin phases installation should be postponed "
	self deny: (space skinPhasesManager isSkinStateApplicationPhaseInstalledIn: space).
	space skinPhasesManager startSkinPhasesIn: space.
	self assert: (space skinPhasesManager isSkinStateApplicationPhaseInstalledIn: space).

]

{ #category : 'tests' }
ToSpaceSkinPhasesManagerTest >> testOnInstalledIn [

	space checkSkinPhases.
	" since space is not opened, the skin phases installation should be postponed "
	self assert: space skinPhasesManager isSkinPhasesInstallationPostponed.
	space skinPhasesManager stopSkinPhasesIn: space.
	" here nothing is installed nor postponed"
	space skinPhasesManager onInstalledIn: space.
	" since space is not opened, the skin phases installation should be postponed "
	self assert: space skinPhasesManager isSkinPhasesInstallationPostponed
]

{ #category : 'tests' }
ToSpaceSkinPhasesManagerTest >> testOnInstalledIn2 [

	space skinPhasesManager startSkinPhasesIn: space.
	" directly install (bypass the space opened/closed checking) "
	self deny: space skinPhasesManager isSkinPhasesInstallationPostponed.
	space skinPhasesManager stopSkinPhasesIn: space.
	" here nothing is installed nor postponed"
	space skinPhasesManager onInstalledIn: space.
	self deny: space skinPhasesManager skinPhasesInstalled.
	" since space is not opened, the skin phases installation should be postponed "
	self assert: space skinPhasesManager isSkinPhasesInstallationPostponed
]

{ #category : 'tests' }
ToSpaceSkinPhasesManagerTest >> testOnUninstalledIn [

	space checkSkinPhases.
	" since space is not opened, the skin phases installation should be postponed "
	self assert: space skinPhasesManager isSkinPhasesInstallationPostponed.
	space skinPhasesManager onUninstalledIn: space.
	" here nothing is installed nor postponed"
	self deny: space skinPhasesManager isSkinPhasesInstallationPostponed.
	self deny: space skinPhasesManager skinPhasesInstalled
]

{ #category : 'tests' }
ToSpaceSkinPhasesManagerTest >> testPostponeStartSkinPhasesIn [

	space checkSkinPhases.
	space skinPhasesManager onUninstalledIn: space.
	" here nothing is installed nor postponed"
	space skinPhasesManager postponeStartSkinPhasesIn: space.
	self assert: space skinPhasesManager isSkinPhasesInstallationPostponed
]

{ #category : 'tests' }
ToSpaceSkinPhasesManagerTest >> testSkinPhasesInstalled [

	space checkSkinPhases.
	" since space is not opened, the skin phases installation should be postponed "
	self deny: (space skinPhasesManager skinPhasesInstalled).
	space skinPhasesManager startSkinPhasesIn: space.
	self assert: (space skinPhasesManager skinPhasesInstalled).

]

{ #category : 'tests' }
ToSpaceSkinPhasesManagerTest >> testStartSkinInstallerPhaseIn [

	space checkSkinPhases.
	space skinPhasesManager onUninstalledIn: space.
	" here nothing is installed nor postponed"
	space skinPhasesManager startSkinInstallerPhaseIn: space.
	self assert: (space skinPhasesManager isSkinInstallerPhaseInstalledIn: space)
]

{ #category : 'tests' }
ToSpaceSkinPhasesManagerTest >> testStartSkinPhasesIn [

	space checkSkinPhases.
	" since space is not opened, the skin phases installation should be postponed "
	self deny: (space skinPhasesManager isSkinStateApplicationPhaseInstalledIn: space).
	space skinPhasesManager startSkinPhasesIn: space.
	self assert: (space skinPhasesManager isSkinInstallerPhaseInstalledIn: space).
	self assert: (space skinPhasesManager isSkinStateApplicationPhaseInstalledIn: space).

]

{ #category : 'tests' }
ToSpaceSkinPhasesManagerTest >> testStartSkinStateApplicationPhaseIn [

	space checkSkinPhases.
	space skinPhasesManager onUninstalledIn: space.
	" here nothing is installed nor postponed"
	space skinPhasesManager startSkinStateApplicationPhaseIn: space.
	self assert: (space skinPhasesManager isSkinStateApplicationPhaseInstalledIn: space)
]

{ #category : 'tests' }
ToSpaceSkinPhasesManagerTest >> testStopSkinInstallerPhaseIn [

	space checkSkinPhases.
	space skinPhasesManager onUninstalledIn: space.
	" here nothing is installed nor postponed"
	space skinPhasesManager startSkinInstallerPhaseIn: space.
	self assert: (space skinPhasesManager isSkinInstallerPhaseInstalledIn: space).
	space skinPhasesManager stopSkinInstallerPhaseIn: space.
	self deny: (space skinPhasesManager isSkinInstallerPhaseInstalledIn: space).

]

{ #category : 'tests' }
ToSpaceSkinPhasesManagerTest >> testStopSkinPhasesIn [

	space checkSkinPhases.
	" since space is not opened, the skin phases installation should be postponed "
	self deny: (space skinPhasesManager isSkinStateApplicationPhaseInstalledIn: space).
	space skinPhasesManager startSkinPhasesIn: space.
	self assert: space skinPhasesManager skinPhasesInstalled.
	self assert: (space skinPhasesManager isSkinInstallerPhaseInstalledIn: space).
	self assert: (space skinPhasesManager isSkinStateApplicationPhaseInstalledIn: space).
	space skinPhasesManager stopSkinPhasesIn: space.
	self deny: space skinPhasesManager skinPhasesInstalled.
	self deny: (space skinPhasesManager isSkinInstallerPhaseInstalledIn: space).
	self deny: (space skinPhasesManager isSkinStateApplicationPhaseInstalledIn: space).



]

{ #category : 'tests' }
ToSpaceSkinPhasesManagerTest >> testStopSkinStateApplicationPhaseIn [

	space checkSkinPhases.
	space skinPhasesManager onUninstalledIn: space.
	" here nothing is installed nor postponed"
	space skinPhasesManager startSkinStateApplicationPhaseIn: space.
	self assert: (space skinPhasesManager isSkinStateApplicationPhaseInstalledIn: space).
	space skinPhasesManager stopSkinStateApplicationPhaseIn: space.
	self deny: (space skinPhasesManager isSkinStateApplicationPhaseInstalledIn: space)
]
