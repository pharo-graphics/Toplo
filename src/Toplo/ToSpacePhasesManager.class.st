Class {
	#name : #ToSpacePhasesManager,
	#superclass : #Object,
	#instVars : [
		'needSkinInstallPass',
		'needSkinStateApplicationPass',
		'stateGenerations',
		'phasesInstallationDone',
		'nextConfigurationPass',
		'runningConfigurationPass',
		'needConfigurationPass'
	],
	#category : #'Toplo-Core-SpaceFrame'
}

{ #category : #adding }
ToSpacePhasesManager >> addSkinStateGeneration: aValuable [

	stateGenerations add: aValuable
]

{ #category : #'configurations application' }
ToSpacePhasesManager >> applyAllConfigurationsIn: aSpace [

	needConfigurationPass ifFalse: [ ^ self ].
	needConfigurationPass := false.
	runningConfigurationPass := nextConfigurationPass.
	nextConfigurationPass := nextConfigurationPass + 1.
	aSpace root checkConfigurationPassDeeply.

]

{ #category : #'skins application' }
ToSpacePhasesManager >> applyAllEnqueuedStatesIn: aSpace [

	self runStateGenerations.
	needSkinStateApplicationPass ifFalse: [ ^ self ].
	aSpace root applyEnqueuedStatesDeeply.
	needSkinStateApplicationPass := false
]

{ #category : #'skins installation' }
ToSpacePhasesManager >> applyAllSkinInstallersIn: aSpace [

	needSkinInstallPass ifFalse: [ ^ self ].
	" flag it now, before a skin installation pass because nothing prevent a skin installation to ask for another installation.
	This is normally not the case. One known case is the space root installation that induce a skin installation "
	self needSkinInstallPass: false.
	aSpace root applySkinInstallersDeeply
]

{ #category : #initialization }
ToSpacePhasesManager >> checkPhasesIn: aSpace [

	phasesInstallationDone ifTrue: [^ self ].
	self onInstalledIn: aSpace
]

{ #category : #initialization }
ToSpacePhasesManager >> initialize [ 

	super initialize.
	nextConfigurationPass := 0.
	phasesInstallationDone := false.
	needSkinInstallPass := true.
	needSkinStateApplicationPass := true.
	needConfigurationPass := true.
	stateGenerations := OrderedCollection new
]

{ #category : #'phases installation' }
ToSpacePhasesManager >> installedConfigurationPhaseIn: aSpace [

	^ aSpace frame phases
		  detect: [ :p | p isKindOf: ToSpaceConfigurationPhase ]
		  ifNone: [  ]
]

{ #category : #'phases installation' }
ToSpacePhasesManager >> installedSkinInstallerPhaseIn: aSpace [

	^ aSpace frame phases
		  detect: [ :p | p isKindOf: ToSpaceSkinInstallerPhase ]
		  ifNone: [  ]
]

{ #category : #'phases installation' }
ToSpacePhasesManager >> installedSkinStateApplicationPhaseIn: aSpace [

	^ aSpace frame phases
		  detect: [ :p | p isKindOf: ToSpaceSkinStateApplicationPhase ]
		  ifNone: [  ]
]

{ #category : #testing }
ToSpacePhasesManager >> isApplyingConfigurations [ 

	^ nextConfigurationPass = runningConfigurationPass 
]

{ #category : #testing }
ToSpacePhasesManager >> isConfigurationPhaseInstalledIn: aSpace [

	^ (self installedConfigurationPhaseIn: aSpace) notNil
]

{ #category : #testing }
ToSpacePhasesManager >> isSkinInstallerPhaseInstalledIn: aSpace [

	^ (self installedSkinInstallerPhaseIn: aSpace) notNil
]

{ #category : #testing }
ToSpacePhasesManager >> isSkinStateApplicationPhaseInstalledIn: aSpace [

	^ (self installedSkinStateApplicationPhaseIn: aSpace) notNil
]

{ #category : #accessing }
ToSpacePhasesManager >> needConfigurationPass [

	^ needConfigurationPass
]

{ #category : #accessing }
ToSpacePhasesManager >> needSkinInstallPass [

	^ needSkinInstallPass
]

{ #category : #accessing }
ToSpacePhasesManager >> needSkinInstallPass: aBoolean [

	needSkinInstallPass := aBoolean
]

{ #category : #accessing }
ToSpacePhasesManager >> needSkinStateApplicationPass [

	^ needSkinStateApplicationPass
]

{ #category : #accessing }
ToSpacePhasesManager >> needSkinStateApplicationPass: aBoolean [

	needSkinStateApplicationPass := aBoolean
]

{ #category : #testing }
ToSpacePhasesManager >> nextConfigurationPass [ 

	^ nextConfigurationPass 
]

{ #category : #'phases installation' }
ToSpacePhasesManager >> onInstalledIn: aSpace [

	phasesInstallationDone ifTrue: [ ^ self ].
	self startPhasesIn: aSpace 
]

{ #category : #'phases installation' }
ToSpacePhasesManager >> onUninstalledIn: aSpace [ 

	self stopPhasesIn: aSpace.

]

{ #category : #testing }
ToSpacePhasesManager >> phasesInstallationDone [

	^ phasesInstallationDone
]

{ #category : #accessing }
ToSpacePhasesManager >> requestNewConfigurationPass [

	self isApplyingConfigurations ifTrue: [ ^ self ].
	needConfigurationPass := true
]

{ #category : #'skins application' }
ToSpacePhasesManager >> runStateGenerations [

	stateGenerations ifNil: [ ^ self ].
	stateGenerations do: [ :g | g value ].
	stateGenerations reset
]

{ #category : #'configurations application' }
ToSpacePhasesManager >> runningConfigurationPass [

	^ runningConfigurationPass
]

{ #category : #'phases installation' }
ToSpacePhasesManager >> startConfigurationPhaseIn: aSpace [

	| phaseAfter |
	(self isConfigurationPhaseInstalledIn: aSpace) ifTrue: [ ^ self ].
	" The skin phase must be inserted before the layout phase (that must be present) "
	phaseAfter := aSpace frame detectPhase: [ :f |
		              f class = ToSpaceSkinInstallerPhase ].
	aSpace frame
		addPhase: ToSpaceConfigurationPhase new
		before: phaseAfter
]

{ #category : #'phases installation' }
ToSpacePhasesManager >> startPhasesIn: aSpace [

	phasesInstallationDone ifTrue: [ ^ self ].
	self
		startSkinInstallerPhaseIn: aSpace;
		startSkinStateApplicationPhaseIn: aSpace;
		startConfigurationPhaseIn: aSpace.
	phasesInstallationDone := true.
	" If no theme has been already set, now I can set the root default theme
	( *** before skinPhasesInstalled: true *** it would start an endless loop )"

	" reading the theme will install the default "
	aSpace toTheme.
	aSpace
		addEventHandlerOn: BlSpaceRootChangeEvent
		do: [ aSpace toTheme ].

	aSpace dispatchEvent: ToSpacePhasesStarted new.
	aSpace
		addEventHandlerOn: BlSpaceClosedEvent
		doOnce: [ self stopPhasesIn: aSpace ]
]

{ #category : #'phases installation' }
ToSpacePhasesManager >> startSkinInstallerPhaseIn: aSpace [

	| phaseAfter |
	(self isSkinInstallerPhaseInstalledIn: aSpace) ifTrue: [ ^ self ].
	" The skin phase must be inserted before the layout phase (that must be present) "
	phaseAfter := aSpace frame detectPhase: [ :f |
		              f class = BlSpaceFrameLayoutPhase ].
	aSpace frame
		addPhase: ToSpaceSkinInstallerPhase new
		before: phaseAfter
]

{ #category : #'phases installation' }
ToSpacePhasesManager >> startSkinStateApplicationPhaseIn: aSpace [
	| phaseAfter |

	(self isSkinStateApplicationPhaseInstalledIn: aSpace) ifTrue: [ ^ self ].
	" The skin phase must be inserted before the layout phase (that must be present) "
	phaseAfter := aSpace frame detectPhase: [ :f | f class = BlSpaceFrameLayoutPhase ].
	aSpace frame addPhase: ToSpaceSkinStateApplicationPhase new before: phaseAfter
]

{ #category : #'phases installation' }
ToSpacePhasesManager >> stopConfigurationPhaseIn: aSpace [

	(self installedConfigurationPhaseIn: aSpace) ifNotNil: [ :phase |
		aSpace frame removePhase: phase ]
]

{ #category : #'phases installation' }
ToSpacePhasesManager >> stopPhasesIn: aSpace [
	
	phasesInstallationDone ifFalse: [ ^ self ].
	self
		stopSkinInstallerPhaseIn: aSpace;
		stopSkinStateApplicationPhaseIn: aSpace;
		stopConfigurationPhaseIn: aSpace.
	
	" 'stopSkinPhasesIn:' traceCr. "
	phasesInstallationDone := false.
	aSpace dispatchEvent: ToSpacePhasesStopped new
]

{ #category : #'phases installation' }
ToSpacePhasesManager >> stopSkinInstallerPhaseIn: aSpace [

	(self installedSkinInstallerPhaseIn: aSpace) ifNotNil: [ :phase |
		aSpace frame removePhase: phase ]
]

{ #category : #'phases installation' }
ToSpacePhasesManager >> stopSkinStateApplicationPhaseIn: aSpace [

	(self installedSkinStateApplicationPhaseIn: aSpace) ifNotNil: [ :phase |
		aSpace frame removePhase: phase]
]
