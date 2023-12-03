Class {
	#name : 'ToSpaceSkinPhasesManager',
	#superclass : 'Object',
	#instVars : [
		'skinPhasesInstalled',
		'allowSkinPhases',
		'spaceShownEventHandler'
	],
	#category : 'Toplo-Core-SpaceFrame',
	#package : 'Toplo',
	#tag : 'Core-SpaceFrame'
}

{ #category : 'accessing' }
ToSpaceSkinPhasesManager >> allowSkinPhases [

	" useful for testing. tests may want to run phases programmatically"
	^ allowSkinPhases
]

{ #category : 'accessing' }
ToSpaceSkinPhasesManager >> allowSkinPhases: aBoolean [

	" useful for testing. tests may want to run phases programmatically"
	allowSkinPhases := aBoolean
]

{ #category : 'phases installation' }
ToSpaceSkinPhasesManager >> checkSkinPhasesIn: aSpace [

	self allowSkinPhases ifFalse: [
		self onUninstalledIn: aSpace.
		^ self ].
	self onInstalledIn: aSpace
]

{ #category : 'initialization' }
ToSpaceSkinPhasesManager >> initialize [ 

	super initialize.
	skinPhasesInstalled := false.
	allowSkinPhases := true
]

{ #category : 'phases installation' }
ToSpaceSkinPhasesManager >> installedSkinInstallerPhaseIn: aSpace [

	^ aSpace frame phases
		  detect: [ :p | p isKindOf: ToSpaceSkinInstallerPhase ]
		  ifNone: [  ]
]

{ #category : 'phases installation' }
ToSpaceSkinPhasesManager >> installedSkinStatePhaseIn: aSpace [

	^ aSpace frame phases
		  detect: [ :p | p isKindOf: ToSpaceSkinStatePhase ]
		  ifNone: [  ]
]

{ #category : 'testing' }
ToSpaceSkinPhasesManager >> isSkinInstallerPhaseInstalledIn: aSpace [

	^ (self installedSkinInstallerPhaseIn: aSpace) notNil
]

{ #category : 'testing' }
ToSpaceSkinPhasesManager >> isSkinPhasesInstallationPostponed [

	^ spaceShownEventHandler notNil
]

{ #category : 'testing' }
ToSpaceSkinPhasesManager >> isSkinStatePhaseInstalledIn: aSpace [

	^ (self installedSkinStatePhaseIn: aSpace) notNil
]

{ #category : 'phases installation' }
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

{ #category : 'phases installation' }
ToSpaceSkinPhasesManager >> onUninstalledIn: aSpace [ 

	self stopSkinPhasesIn: aSpace.

]

{ #category : 'phases installation' }
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

{ #category : 'accessing' }
ToSpaceSkinPhasesManager >> skinPhasesInstalled [

	^ skinPhasesInstalled
]

{ #category : 'accessing' }
ToSpaceSkinPhasesManager >> skinPhasesInstalled: aBoolean [

	skinPhasesInstalled := aBoolean
]

{ #category : 'phases installation' }
ToSpaceSkinPhasesManager >> startSkinInstallerPhaseIn: aSpace [
	| phaseAfter |

	(self isSkinInstallerPhaseInstalledIn: aSpace) ifTrue: [ ^ self ].
	" The skin phase must be inserted before the layout phase (that must be present) "
	phaseAfter := aSpace frame detectPhase: [ :f | f class = BlSpaceFrameLayoutPhase ].
	aSpace frame addPhase: ToSpaceSkinInstallerPhase new before: phaseAfter
]

{ #category : 'phases installation' }
ToSpaceSkinPhasesManager >> startSkinPhasesIn: aSpace [

	self skinPhasesInstalled ifTrue: [ ^ self ].
	self
		startSkinInstallerPhaseIn: aSpace;
		startSkinStatePhaseIn: aSpace.
	
	self skinPhasesInstalled: true.
	" If no theme has been already set, now I can set the root default theme
	( before skinPhasesInstalled: true it would start an endless loop )"
	
	" reading the theme will install the default "
	aSpace toTheme.
	aSpace addEventHandlerOn: BlSpaceRootChangeEvent do: [ 
		aSpace toTheme ].

	aSpace dispatchEvent: ToSpaceSkinPhasesStarted new.
	aSpace
		when: BlSpaceClosedEvent
		doOnce: [ 
			self stopSkinPhasesIn: aSpace ]
]

{ #category : 'phases installation' }
ToSpaceSkinPhasesManager >> startSkinStatePhaseIn: aSpace [
	| phaseAfter |

	(self isSkinStatePhaseInstalledIn: aSpace) ifTrue: [ ^ self ].
	" The skin phase must be inserted before the layout phase (that must be present) "
	phaseAfter := aSpace frame detectPhase: [ :f | f class = BlSpaceFrameLayoutPhase ].
	aSpace frame addPhase: ToSpaceSkinStatePhase new before: phaseAfter
]

{ #category : 'phases installation' }
ToSpaceSkinPhasesManager >> stopSkinInstallerPhaseIn: aSpace [

	(self installedSkinInstallerPhaseIn: aSpace) ifNotNil: [ :phase |
		aSpace frame removePhase: phase ]
]

{ #category : 'phases installation' }
ToSpaceSkinPhasesManager >> stopSkinPhasesIn: aSpace [

	self isSkinPhasesInstallationPostponed ifTrue: [ 
		aSpace removeEventHandler: spaceShownEventHandler.
		spaceShownEventHandler := nil. ].
	
	self skinPhasesInstalled ifFalse: [ ^ self ].
	self
		stopSkinInstallerPhaseIn: aSpace;
		stopSkinStatePhaseIn: aSpace.
	
	" 'stopSkinPhasesIn:' traceCr. "
	self skinPhasesInstalled: false.
	aSpace dispatchEvent: ToSpaceSkinPhasesStopped new
]

{ #category : 'phases installation' }
ToSpaceSkinPhasesManager >> stopSkinStatePhaseIn: aSpace [

	(self installedSkinStatePhaseIn: aSpace) ifNotNil: [ :phase |
		aSpace frame removePhase: phase]
]
