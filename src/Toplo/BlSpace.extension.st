Extension { #name : 'BlSpace' }

{ #category : '*Toplo' }
BlSpace >> applySkinInstaller [

	self elementsWithSkinInstaller do: [ :e | e applySkinInstaller ].
	self resetElementsWithSkinInstaller
]

{ #category : '*Toplo' }
BlSpace >> elementWithSkinInstaller: anElement [

	self elementsWithSkinInstaller add: anElement
]

{ #category : '*Toplo' }
BlSpace >> elementWithUnappliedStates: anElement [

	self elementsWithUnappliedStates add: anElement
]

{ #category : '*Toplo' }
BlSpace >> elementsWithSkinInstaller [

	^ self userData at: #elementsWithSkinInstaller ifAbsentPut: [ IdentitySet new ]
]

{ #category : '*Toplo' }
BlSpace >> elementsWithUnappliedStates [

	^ self userData at: #elementsWithUnappliedStates ifAbsentPut: [ IdentitySet new ]
]

{ #category : '*Toplo' }
BlSpace >> flushSkinStates [
	
	self elementsWithUnappliedStates do: [ :e | e flushSkinStates ].
	self resetElementsWithUnappliedStates 
]

{ #category : '*Toplo' }
BlSpace >> installedSkinInstallerPhase [

	^ self frame phases
		  detect: [ :p | p isKindOf: ToSpaceSkinInstallerPhase ]
		  ifNone: [  ]
]

{ #category : '*Toplo' }
BlSpace >> installedSkinStatePhase [

	^ self frame phases
		  detect: [ :p | p isKindOf: ToSpaceSkinStatePhase ]
		  ifNone: [  ]
]

{ #category : '*Toplo' }
BlSpace >> isSkinInstallerPhaseInstalled [

	^ self installedSkinInstallerPhase notNil
]

{ #category : '*Toplo' }
BlSpace >> isSkinStatePhaseInstalled [

	^ self installedSkinStatePhase notNil
]

{ #category : '*Toplo' }
BlSpace >> resetElementsWithSkinInstaller [

	^ self userData at: #elementsWithSkinInstaller put: IdentitySet new
]

{ #category : '*Toplo' }
BlSpace >> resetElementsWithUnappliedStates [

	^ self userData at: #elementsWithUnappliedStates put: IdentitySet new
]

{ #category : '*Toplo' }
BlSpace >> rootSkinInstalled [

	^ self root installedSkin notNil

]

{ #category : '*Toplo' }
BlSpace >> startSkinInstallerPhase [
	| layoutPhase |

	self isSkinInstallerPhaseInstalled ifTrue: [ ^ self ].
	" The skin phase must be inserted before the layout phase (that must be present) "
	layoutPhase := self frame detectPhase: [ :f | f class = BlSpaceFrameLayoutPhase ].
	self frame addPhase: ToSpaceSkinInstallerPhase new before: layoutPhase
]

{ #category : '*Toplo' }
BlSpace >> startSkinStatePhase [
	| layoutPhase |

	self isSkinStatePhaseInstalled ifTrue: [ ^ self ].
	" The skin phase must be inserted before the layout phase (that must be present) "
	layoutPhase := self frame detectPhase: [ :f | f class = BlSpaceFrameLayoutPhase ].
	self frame addPhase: ToSpaceSkinStatePhase new before: layoutPhase
]

{ #category : '*Toplo' }
BlSpace >> stopSkinInstallerPhase [

	self installedSkinInstallerPhase ifNotNil: [ :phase |
		self frame removePhase: phase ]
]

{ #category : '*Toplo' }
BlSpace >> stopSkinStatePhase [

	self installedSkinStatePhase ifNotNil: [ :phase |
		self frame removePhase: phase ]
]

{ #category : '*Toplo-LookAndFeel' }
BlSpace >> toTheme [

	^ self root toTheme
]

{ #category : '*Toplo-LookAndFeel' }
BlSpace >> toTheme: aTheme [

	self root toTheme: aTheme
]
