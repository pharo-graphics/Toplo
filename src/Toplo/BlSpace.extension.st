Extension { #name : #BlSpace }

{ #category : #'*Toplo' }
BlSpace >> applySkinInstaller [

	self elementsWithSkinInstaller do: [ :e | e applySkinInstaller ].
	self resetElementsWithSkinInstaller
]

{ #category : #'*Toplo' }
BlSpace >> elementWithSkinInstaller: anElement [

	self elementsWithSkinInstaller add: anElement
]

{ #category : #'*Toplo' }
BlSpace >> elementsWithSkinInstaller [

	^ self userData at: #elementsWithSkinInstaller ifAbsentPut: [ IdentitySet new ]
]

{ #category : #'*Toplo' }
BlSpace >> elementsWithUnappliedStates [

	^ self userData at: #elementsWithUnappliedStates ifAbsentPut: [ #() ]
]

{ #category : #'*Toplo' }
BlSpace >> elementsWithUnappliedStates: anArray [

	^ self userData at: #elementsWithUnappliedStates put: anArray
]

{ #category : #'*Toplo' }
BlSpace >> flushSkinStates [
	
	self elementsWithUnappliedStates do: [ :e | e flushSkinStates ].
	self resetElementsWithUnappliedStates 
]

{ #category : #'*Toplo' }
BlSpace >> installedSkinInstallerPhase [

	^ self frame phases
		  detect: [ :p | p isKindOf: ToSpaceSkinInstallerPhase ]
		  ifNone: [  ]
]

{ #category : #'*Toplo' }
BlSpace >> installedSkinStatePhase [

	^ self frame phases
		  detect: [ :p | p isKindOf: ToSpaceSkinStatePhase ]
		  ifNone: [  ]
]

{ #category : #'*Toplo' }
BlSpace >> isSkinInstallerPhaseInstalled [

	^ self installedSkinInstallerPhase notNil
]

{ #category : #'*Toplo' }
BlSpace >> isSkinStatePhaseInstalled [

	^ self installedSkinStatePhase notNil
]

{ #category : #'*Toplo' }
BlSpace >> requestSkinApplicationFor: anElement [

	self elementsWithUnappliedStates:
		((self elementsWithUnappliedStates copyWithout: anElement)
			 copyWith: anElement)
]

{ #category : #'*Toplo' }
BlSpace >> resetElementsWithSkinInstaller [

	^ self userData at: #elementsWithSkinInstaller put: IdentitySet new
]

{ #category : #'*Toplo' }
BlSpace >> resetElementsWithUnappliedStates [

	"self elementsWithUnappliedStates do: [ :e | e traceCr ]."
	self userData at: #elementsWithUnappliedStates put: #()
]

{ #category : #'*Toplo' }
BlSpace >> rootSkinInstalled [

	^ self root installedSkin notNil

]

{ #category : #'*Toplo' }
BlSpace >> startSkinInstallerPhase [
	| phaseAfter |

	self isSkinInstallerPhaseInstalled ifTrue: [ ^ self ].
	" The skin phase must be inserted before the layout phase (that must be present) "
	phaseAfter := self frame detectPhase: [ :f | f class = BlSpaceFrameLayoutPhase ].
	self frame addPhase: ToSpaceSkinInstallerPhase new before: phaseAfter
]

{ #category : #'*Toplo' }
BlSpace >> startSkinStatePhase [
	| phaseAfter |

	self isSkinStatePhaseInstalled ifTrue: [ ^ self ].
	" The skin phase must be inserted before the layout phase (that must be present) "
	phaseAfter := self frame detectPhase: [ :f | f class = BlSpaceFrameLayoutPhase ].
	self frame addPhase: ToSpaceSkinStatePhase new before: phaseAfter
]

{ #category : #'*Toplo' }
BlSpace >> stopSkinInstallerPhase [

	self installedSkinInstallerPhase ifNotNil: [ :phase |
		self frame removePhase: phase ]
]

{ #category : #'*Toplo' }
BlSpace >> stopSkinStatePhase [

	self installedSkinStatePhase ifNotNil: [ :phase |
		self frame removePhase: phase ]
]

{ #category : #'*Toplo-LookAndFeel' }
BlSpace >> toTheme [

	^ self root toTheme
]

{ #category : #'*Toplo-LookAndFeel' }
BlSpace >> toTheme: aTheme [

	self root toTheme: aTheme
]
