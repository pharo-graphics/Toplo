Extension { #name : #BlSpace }

{ #category : #'*Toplo' }
BlSpace >> addDraggedSkinStateGeneration: aValuable [

	self skinPhasesManager addDraggedSkinStateGeneration: aValuable
]

{ #category : #'*Toplo' }
BlSpace >> addSkinStateGeneration: aValuable [

	self skinPhasesManager addSkinStateGeneration: aValuable
]

{ #category : #'*Toplo' }
BlSpace >> allowSkinPhases [

	^ self skinPhasesManager allowSkinPhases
]

{ #category : #'*Toplo' }
BlSpace >> allowSkinPhases: aBoolean [

	" useful for testing. tests may want to run phases programmatically"
	self skinPhasesManager allowSkinPhases: aBoolean.
	self skinPhasesManager checkSkinPhasesIn: self
]

{ #category : #'*Toplo' }
BlSpace >> applyAllEnqueuedStates [

	self skinPhasesManager applyAllEnqueuedStatesIn: self
]

{ #category : #'*Toplo' }
BlSpace >> applyAllSkinInstallers [

	self skinPhasesManager applyAllSkinInstallersIn: self
]

{ #category : #'*Toplo' }
BlSpace >> checkSkinPhases [

	self skinPhasesManager skinPhasesInstalled ifTrue: [^ self ].
	self skinPhasesManager onInstalledIn: self
]

{ #category : #'*Toplo' }
BlSpace >> needSkinInstallPass [

	^ self skinPhasesManager needSkinInstallPass
]

{ #category : #'*Toplo' }
BlSpace >> needSkinInstallPass: aBoolean [

	self skinPhasesManager needSkinInstallPass: aBoolean
]

{ #category : #'*Toplo' }
BlSpace >> renewRootStyleSheet [

	self root styleSheet: self toTheme styleSheet
]

{ #category : #'*Toplo' }
BlSpace >> runStatesGeneration [

	self skinPhasesManager runStatesGeneration
]

{ #category : #'*Toplo' }
BlSpace >> skinPhasesInstalled [

	^ self skinPhasesManager skinPhasesInstalled
]

{ #category : #'*Toplo' }
BlSpace >> skinPhasesManager [

	^ self userData at: #skinPhasesManager ifAbsentPut: [ ToSpaceSkinPhasesManager new ]
]

{ #category : #'*Toplo' }
BlSpace >> startSkinPhases [

	self skinPhasesManager startSkinPhasesIn: self
]

{ #category : #'*Toplo' }
BlSpace >> stopSkinPhases [

	self skinPhasesManager stopSkinPhasesIn: self
]

{ #category : #'*Toplo-LookAndFeel' }
BlSpace >> toTheme [

	^ self userData at: #toTheme ifAbsent: [  self toTheme: Toplo newDefaultThemeInstance. self toTheme ]
]

{ #category : #'*Toplo-LookAndFeel' }
BlSpace >> toTheme: aTheme [

	self userData at: #toTheme put: aTheme.
	aTheme onInstalledIn:  self.
	self root toThemeChanged
]

{ #category : #'*Toplo' }
BlSpace >> uninstallSkinPhases [

	self skinPhasesManager onUninstalledIn: self
]
