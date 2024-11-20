Extension { #name : #BlSpace }

{ #category : #'*Toplo' }
BlSpace >> addDraggedSkinStateGeneration: aValuable [

	self skinPhasesManager addSkinStateGeneration: aValuable.
	self requestNextPulse 
]

{ #category : #'*Toplo' }
BlSpace >> addSkinStateGeneration: aValuable [

	self skinPhasesManager addSkinStateGeneration: aValuable.
	self requestNextPulse
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
BlSpace >> applyAllSkinPhases [

	self applyAllSkinInstallers.
	self applyAllEnqueuedStates.
]

{ #category : #'*Toplo' }
BlSpace >> checkSkinPhases [

	self skinPhasesManager skinPhasesInstalled ifTrue: [^ self ].
	self skinPhasesManager onInstalledIn: self
]

{ #category : #'*Toplo' }
BlSpace >> isApplyingSkinInstallers [

	^ self skinPhasesManager isApplyingSkinInstallers
]

{ #category : #'*Toplo' }
BlSpace >> needSkinInstallPass [

	^ self skinPhasesManager needSkinInstallPass
]

{ #category : #'*Toplo' }
BlSpace >> needSkinInstallPass: aBoolean [

	self skinPhasesManager needSkinInstallPass: aBoolean.
	aBoolean ifTrue: [ self requestNextPulse ]
]

{ #category : #'*Toplo' }
BlSpace >> needSkinStateApplicationPass [

	^ self skinPhasesManager needSkinStateApplicationPass
]

{ #category : #'*Toplo' }
BlSpace >> needSkinStateApplicationPass: aBoolean [

	self skinPhasesManager needSkinStateApplicationPass: aBoolean.
	aBoolean ifTrue: [ self requestNextPulse ]
]

{ #category : #'*Toplo-LookAndFeel' }
BlSpace >> resetToTheme [

	self toTheme: Toplo newDefaultThemeInstance
]

{ #category : #'*Toplo' }
BlSpace >> runStateGenerations [

	self skinPhasesManager runStateGenerations
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

	^ self userData at: #toTheme ifAbsent: [
		  SystemAnnouncer uniqueInstance weak
			  when: ToThemeSettingChangedEvent
			  send: #resetToTheme
			  to: self.
		  self resetToTheme.
		  self userData at: #toTheme ]
]

{ #category : #'*Toplo-LookAndFeel' }
BlSpace >> toTheme: aTheme [

	self userData at: #toTheme put: aTheme.
	self root ensureCanManageSkin.
	self root localTheme: aTheme
]

{ #category : #'*Toplo' }
BlSpace >> uninstallSkinPhases [

	self skinPhasesManager onUninstalledIn: self
]
