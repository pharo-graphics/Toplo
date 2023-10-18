Extension { #name : 'BlSpace' }

{ #category : '*Toplo' }
BlSpace >> applySkinInstaller [

	self rootSkinInstalled ifFalse: [
		self root requestSkin: self root defaultSkin ].
	self root applySkinInstaller
]

{ #category : '*Toplo' }
BlSpace >> applySkinStates [

	self root applySkinStates
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
