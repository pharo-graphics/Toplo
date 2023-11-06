Class {
	#name : 'ToSpaceSkinPhasesManager',
	#superclass : 'Object',
	#instVars : [
		'skinPhasesInstalled',
		'allowSkinPhases',
		'elementsWithSkinInstaller',
		'elementsWithUnappliedStates',
		'startSkinPhasesArmed',
		'spaceShownEventHandler'
	],
	#category : 'Toplo-Core-Skin',
	#package : 'Toplo',
	#tag : 'Core-Skin'
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

{ #category : 'phases application' }
ToSpaceSkinPhasesManager >> applySkinInstaller [

	self allowSkinPhases ifFalse: [ ^ self ].
	self elementsWithSkinInstaller do: [ :e | e applySkinInstaller ].
	self resetElementsWithSkinInstaller
]

{ #category : 'initialization' }
ToSpaceSkinPhasesManager >> armStartSkinPhasesIn: aSpace [

	spaceShownEventHandler := BlEventHandler new.
	spaceShownEventHandler eventClass: BlSpaceShownEvent.
	spaceShownEventHandler action: [
		'space opened -> startSkinPhasesIn:' traceCr.
		aSpace removeEventHandler: spaceShownEventHandler.
		spaceShownEventHandler := nil.
		self startSkinPhasesIn: aSpace ].
	aSpace addEventHandler: spaceShownEventHandler
]

{ #category : 'accessing' }
ToSpaceSkinPhasesManager >> elementsWithSkinInstaller [

	^ elementsWithSkinInstaller 
]

{ #category : 'accessing' }
ToSpaceSkinPhasesManager >> elementsWithSkinInstaller: anArray [

	elementsWithSkinInstaller := anArray
]

{ #category : 'accessing' }
ToSpaceSkinPhasesManager >> elementsWithUnappliedStates [

	^ elementsWithUnappliedStates 
]

{ #category : 'accessing' }
ToSpaceSkinPhasesManager >> elementsWithUnappliedStates: anArray [

	elementsWithUnappliedStates := anArray
]

{ #category : 'phases application' }
ToSpaceSkinPhasesManager >> flushSkinStates [
	
	self allowSkinPhases ifFalse: [ ^ self ].
	self elementsWithUnappliedStates do: [ :e | e flushSkinStates ].
	self resetElementsWithDirtySkin 
]

{ #category : 'initialization' }
ToSpaceSkinPhasesManager >> initialize [ 

	super initialize.
	startSkinPhasesArmed := false.
	skinPhasesInstalled := false.
	allowSkinPhases := true.
	elementsWithSkinInstaller := #().
	elementsWithUnappliedStates := #().
	spaceShownEventHandler := nil

	
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
ToSpaceSkinPhasesManager >> isSkinStatePhaseInstalledIn: aSpace [

	^ (self installedSkinStatePhaseIn: aSpace) notNil
]

{ #category : 'initialization' }
ToSpaceSkinPhasesManager >> onInstalledIn: aSpace [

	self skinPhasesInstalled ifTrue: [ ^ self ].
	aSpace isOpened
		ifTrue: [ 
			"'space already opened -> startSkinPhasesIn:' traceCr."
			self startSkinPhasesIn: aSpace ]
		ifFalse: [
			self startSkinPhasesArmed ifTrue: [ 
				"'space not oppened -> startSkinPhasesArmed already armed' traceCr."
				^ self ].
			"'space not oppened -> startSkinPhasesArmed ' traceCr."
			self armStartSkinPhasesIn: aSpace ]
]

{ #category : 'initialization' }
ToSpaceSkinPhasesManager >> onUninstalledIn: aSpace [ 

	self skinPhasesInstalled ifFalse: [ ^ self ].
	self skinPhasesInstalled: false.
	self stopSkinPhasesIn: aSpace.

]

{ #category : 'phases application' }
ToSpaceSkinPhasesManager >> resetElementsWithDirtySkin [

	self elementsWithUnappliedStates: #()
]

{ #category : 'phases application' }
ToSpaceSkinPhasesManager >> resetElementsWithSkinInstaller [

	self elementsWithSkinInstaller: #()
]

{ #category : 'phases application' }
ToSpaceSkinPhasesManager >> skinInstallerSetIn: anElement [

	self elementsWithSkinInstaller:
		((self elementsWithSkinInstaller copyWithout: anElement)
			 copyWith: anElement)
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

{ #category : 'accessing' }
ToSpaceSkinPhasesManager >> startSkinPhasesArmed [

	^ spaceShownEventHandler notNil
]

{ #category : 'phases installation' }
ToSpaceSkinPhasesManager >> startSkinPhasesIn: aSpace [

	self skinPhasesInstalled ifTrue: [ ^ self ].
	self
		startSkinInstallerPhaseIn: aSpace;
		startSkinStatePhaseIn: aSpace.
	self skinPhasesInstalled: true.
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

{ #category : 'initialization' }
ToSpaceSkinPhasesManager >> stopSkinInstallerPhaseIn: aSpace [

	(self installedSkinInstallerPhaseIn: aSpace) ifNotNil: [ :phase |
		aSpace frame removePhase: phase ]
]

{ #category : 'phases installation' }
ToSpaceSkinPhasesManager >> stopSkinPhasesIn: aSpace [

	self skinPhasesInstalled ifFalse: [ ^ self ].
	self
		stopSkinInstallerPhaseIn: aSpace;
		stopSkinStatePhaseIn: aSpace.
	
	'stopSkinPhasesIn:' traceCr.
	self skinPhasesInstalled: false.
	aSpace dispatchEvent: ToSpaceSkinPhasesStopped new
]

{ #category : 'initialization' }
ToSpaceSkinPhasesManager >> stopSkinStatePhaseIn: aSpace [

	(self installedSkinStatePhaseIn: aSpace) ifNotNil: [ :phase |
		aSpace frame removePhase: phase]
]

{ #category : 'phases application' }
ToSpaceSkinPhasesManager >> styleDirtyIn: anElement [

	self elementsWithUnappliedStates:
		((self elementsWithUnappliedStates copyWithout: anElement)
			 copyWith: anElement)
]
