Extension { #name : 'BlSpace' }

{ #category : '*Toplo' }
BlSpace >> allowSkinPhases [

	^ self skinPhasesManager allowSkinPhases
]

{ #category : '*Toplo' }
BlSpace >> allowSkinPhases: aBoolean [

	" useful for testing. tests may want to run phases programmatically"
	self skinPhasesManager allowSkinPhases: aBoolean.
	self skinPhasesManager checkSkinPhasesIn: self
]

{ #category : '*Toplo' }
BlSpace >> applyAllSkinInstallers [

	self root applySkinInstallerRecursively
]

{ #category : '*Toplo' }
BlSpace >> applyAllStyles [

	self root applyEnqueuedStatesRecursively
]

{ #category : '*Toplo' }
BlSpace >> checkSkinPhases [

	self skinPhasesManager skinPhasesInstalled ifTrue: [^ self ].
	self skinPhasesManager onInstalledIn: self
]

{ #category : '*Toplo' }
BlSpace >> renewRootStyleSheet [

	self root styleSheet: self toTheme newStyleSheet
]

{ #category : '*Toplo' }
BlSpace >> skinPhasesManager [

	^ self userData at: #skinPhasesManager ifAbsentPut: [ ToSpaceSkinPhasesManager new ]
]

{ #category : '*Toplo' }
BlSpace >> startSkinPhases [

	self skinPhasesManager startSkinPhasesIn: self
]

{ #category : '*Toplo' }
BlSpace >> stopSkinPhases [

	self skinPhasesManager stopSkinPhasesIn: self
]

{ #category : '*Toplo-LookAndFeel' }
BlSpace >> toTheme [

	^ self userData at: #toTheme ifAbsent: [ self toTheme: ToTheme current. self toTheme ]
]

{ #category : '*Toplo-LookAndFeel' }
BlSpace >> toTheme: aTheme [

	self userData at: #toTheme put: aTheme.
	self root addAllTokenProperties: aTheme defaultTokenProperties.
	self root toThemeChanged
]

{ #category : '*Toplo' }
BlSpace >> uninstallSkinPhases [

	self skinPhasesManager onUninstalledIn: self
]
