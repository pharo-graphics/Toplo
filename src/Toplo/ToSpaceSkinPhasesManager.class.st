Class {
	#name : #ToSpaceSkinPhasesManager,
	#superclass : #Object,
	#instVars : [
		'skinPhasesInstalled',
		'allowSkinPhases',
		'spaceShownEventHandler',
		'needSkinInstallPass',
		'needSkinStateApplicationPass',
		'stateGenerations',
		'needInnerConfigurationPass'
	],
	#category : #'Toplo-Core-SpaceFrame'
}

{ #category : #adding }
ToSpaceSkinPhasesManager >> addSkinStateGeneration: aValuable [

	stateGenerations add: aValuable
]

{ #category : #accessing }
ToSpaceSkinPhasesManager >> allowSkinPhases [

	" useful for testing. tests may want to run phases programmatically"
	^ allowSkinPhases
]

{ #category : #accessing }
ToSpaceSkinPhasesManager >> allowSkinPhases: aBoolean [

	" useful for testing. tests may want to run phases programmatically"
	allowSkinPhases := aBoolean
]

{ #category : #'phases application' }
ToSpaceSkinPhasesManager >> applyAllEnqueuedStatesIn: aSpace [

	self runStateGenerations.
	self needSkinStateApplicationPass ifFalse: [ ^ self ].
	aSpace root applyEnqueuedStatesDeeply.
	self needSkinStateApplicationPass: false
]

{ #category : #'phases application' }
ToSpaceSkinPhasesManager >> applyAllInnerConfigurationsIn: aSpace [

	self needInnerConfigurationPass ifFalse: [ ^ self ].
	self needInnerConfigurationPass: false.
	aSpace root checkInnerConfigurationsDeeply
]

{ #category : #'phases application' }
ToSpaceSkinPhasesManager >> applyAllSkinInstallersIn: aSpace [

	self needSkinInstallPass ifFalse: [ ^ self ].
	" flag it now, before a skin installation pass because nothing prevent a skin installation to ask for another installation.
	This is normally not the case. One known case is the space root installation that induce a skin installation "
	self needSkinInstallPass: false.
	aSpace root applySkinInstallersDeeply
]

{ #category : #'phases installation' }
ToSpaceSkinPhasesManager >> checkSkinPhasesIn: aSpace [

	self allowSkinPhases ifFalse: [
		self onUninstalledIn: aSpace.
		^ self ].
	self onInstalledIn: aSpace
]

{ #category : #initialization }
ToSpaceSkinPhasesManager >> initialize [ 

	super initialize.
	skinPhasesInstalled := false.
	allowSkinPhases := true.
	needSkinInstallPass := true.
	needSkinStateApplicationPass := true.
	needInnerConfigurationPass := true.
	stateGenerations := OrderedCollection new
]

{ #category : #'phases installation' }
ToSpaceSkinPhasesManager >> installedInnerConfigurationPhaseIn: aSpace [

	^ aSpace frame phases
		  detect: [ :p | p isKindOf: ToSpaceInnerConfigurationPhase ]
		  ifNone: [  ]
]

{ #category : #'phases installation' }
ToSpaceSkinPhasesManager >> installedSkinInstallerPhaseIn: aSpace [

	^ aSpace frame phases
		  detect: [ :p | p isKindOf: ToSpaceSkinInstallerPhase ]
		  ifNone: [  ]
]

{ #category : #'phases installation' }
ToSpaceSkinPhasesManager >> installedSkinStateApplicationPhaseIn: aSpace [

	^ aSpace frame phases
		  detect: [ :p | p isKindOf: ToSpaceSkinStateApplicationPhase ]
		  ifNone: [  ]
]

{ #category : #testing }
ToSpaceSkinPhasesManager >> isInnerConfigurationPhaseInstalledIn: aSpace [

	^ (self installedInnerConfigurationPhaseIn: aSpace) notNil
]

{ #category : #testing }
ToSpaceSkinPhasesManager >> isSkinInstallerPhaseInstalledIn: aSpace [

	^ (self installedSkinInstallerPhaseIn: aSpace) notNil
]

{ #category : #testing }
ToSpaceSkinPhasesManager >> isSkinPhasesInstallationPostponed [

	^ spaceShownEventHandler notNil
]

{ #category : #testing }
ToSpaceSkinPhasesManager >> isSkinStateApplicationPhaseInstalledIn: aSpace [

	^ (self installedSkinStateApplicationPhaseIn: aSpace) notNil
]

{ #category : #accessing }
ToSpaceSkinPhasesManager >> needInnerConfigurationPass [

	^ needInnerConfigurationPass
]

{ #category : #accessing }
ToSpaceSkinPhasesManager >> needInnerConfigurationPass: aBoolean [

	needInnerConfigurationPass := aBoolean
]

{ #category : #accessing }
ToSpaceSkinPhasesManager >> needSkinInstallPass [

	^ needSkinInstallPass
]

{ #category : #accessing }
ToSpaceSkinPhasesManager >> needSkinInstallPass: aBoolean [

	needSkinInstallPass := aBoolean
]

{ #category : #accessing }
ToSpaceSkinPhasesManager >> needSkinStateApplicationPass [

	^ needSkinStateApplicationPass
]

{ #category : #accessing }
ToSpaceSkinPhasesManager >> needSkinStateApplicationPass: aBoolean [

	needSkinStateApplicationPass := aBoolean
]

{ #category : #'phases installation' }
ToSpaceSkinPhasesManager >> onInstalledIn: aSpace [

	self skinPhasesInstalled ifTrue: [ ^ self ].
	self allowSkinPhases ifFalse: [ ^ self ].
	aSpace isOpened
		ifTrue: [ 
			"'space already opened -> startSkinPhasesIn:' traceCr."
			self startSkinPhasesIn: aSpace ]
		ifFalse: [
			self isSkinPhasesInstallationPostponed ifTrue: [ 
				"'space not oppened -> startSkinPhasesArmed already armed' traceCr."
				^ self ].
			"'space not oppened -> startSkinPhasesArmed ' traceCr."
			self postponeStartSkinPhasesIn: aSpace ]
]

{ #category : #'phases installation' }
ToSpaceSkinPhasesManager >> onUninstalledIn: aSpace [ 

	self stopSkinPhasesIn: aSpace.

]

{ #category : #'phases installation' }
ToSpaceSkinPhasesManager >> postponeStartSkinPhasesIn: aSpace [

	spaceShownEventHandler := BlEventHandler new.
	spaceShownEventHandler eventClass: BlSpaceShownEvent.
	spaceShownEventHandler action: [
		"'space opened -> startSkinPhasesIn:' traceCr."
		aSpace removeEventHandler: spaceShownEventHandler.
		spaceShownEventHandler := nil.
		self startSkinPhasesIn: aSpace ].
	aSpace addEventHandler: spaceShownEventHandler
]

{ #category : #'phases application' }
ToSpaceSkinPhasesManager >> runStateGenerations [

	stateGenerations ifNil: [ ^ self ].
	stateGenerations do: [ :g | g value ].
	stateGenerations reset
]

{ #category : #accessing }
ToSpaceSkinPhasesManager >> skinPhasesInstalled [

	^ skinPhasesInstalled
]

{ #category : #accessing }
ToSpaceSkinPhasesManager >> skinPhasesInstalled: aBoolean [

	skinPhasesInstalled := aBoolean
]

{ #category : #'phases installation' }
ToSpaceSkinPhasesManager >> startInnerConfigurationPhaseIn: aSpace [

	| phaseAfter |
	(self isInnerConfigurationPhaseInstalledIn: aSpace) ifTrue: [ ^ self ].
	" The skin phase must be inserted before the layout phase (that must be present) "
	phaseAfter := aSpace frame detectPhase: [ :f |
		              f class = ToSpaceSkinInstallerPhase ].
	aSpace frame
		addPhase: ToSpaceInnerConfigurationPhase new
		before: phaseAfter
]

{ #category : #'phases installation' }
ToSpaceSkinPhasesManager >> startSkinInstallerPhaseIn: aSpace [

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
ToSpaceSkinPhasesManager >> startSkinPhasesIn: aSpace [

	self skinPhasesInstalled ifTrue: [ ^ self ].
	self allowSkinPhases ifFalse: [ ^ self ].
	self isSkinPhasesInstallationPostponed ifTrue: [
		aSpace removeEventHandler: spaceShownEventHandler.
		spaceShownEventHandler := nil ].
	self
		startSkinInstallerPhaseIn: aSpace;
		startSkinStateApplicationPhaseIn: aSpace;
		startInnerConfigurationPhaseIn: aSpace.
	self skinPhasesInstalled: true.
	" If no theme has been already set, now I can set the root default theme
	( *** before skinPhasesInstalled: true *** it would start an endless loop )"

	" reading the theme will install the default "
	aSpace toTheme.
	aSpace
		addEventHandlerOn: BlSpaceRootChangeEvent
		do: [ aSpace toTheme ].

	aSpace dispatchEvent: ToSpaceSkinPhasesStarted new.
	aSpace
		addEventHandlerOn: BlSpaceClosedEvent
		doOnce: [ self stopSkinPhasesIn: aSpace ]
]

{ #category : #'phases installation' }
ToSpaceSkinPhasesManager >> startSkinStateApplicationPhaseIn: aSpace [
	| phaseAfter |

	(self isSkinStateApplicationPhaseInstalledIn: aSpace) ifTrue: [ ^ self ].
	" The skin phase must be inserted before the layout phase (that must be present) "
	phaseAfter := aSpace frame detectPhase: [ :f | f class = BlSpaceFrameLayoutPhase ].
	aSpace frame addPhase: ToSpaceSkinStateApplicationPhase new before: phaseAfter
]

{ #category : #'phases installation' }
ToSpaceSkinPhasesManager >> stopSkinInstallerPhaseIn: aSpace [

	(self installedSkinInstallerPhaseIn: aSpace) ifNotNil: [ :phase |
		aSpace frame removePhase: phase ]
]

{ #category : #'phases installation' }
ToSpaceSkinPhasesManager >> stopSkinPhasesIn: aSpace [

	self isSkinPhasesInstallationPostponed ifTrue: [ 
		aSpace removeEventHandler: spaceShownEventHandler.
		spaceShownEventHandler := nil. ].
	
	self skinPhasesInstalled ifFalse: [ ^ self ].
	self
		stopSkinInstallerPhaseIn: aSpace;
		stopSkinStateApplicationPhaseIn: aSpace.
	
	" 'stopSkinPhasesIn:' traceCr. "
	self skinPhasesInstalled: false.
	aSpace dispatchEvent: ToSpaceSkinPhasesStopped new
]

{ #category : #'phases installation' }
ToSpaceSkinPhasesManager >> stopSkinStateApplicationPhaseIn: aSpace [

	(self installedSkinStateApplicationPhaseIn: aSpace) ifNotNil: [ :phase |
		aSpace frame removePhase: phase]
]
