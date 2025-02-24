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
BlSpace >> applyAllEnqueuedStates [

	self skinPhasesManager applyAllEnqueuedStatesIn: self
]

{ #category : #'*Toplo' }
BlSpace >> applyAllInnerConfigurations [

	self skinPhasesManager applyAllInnerConfigurationsIn: self
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

	self skinPhasesManager checkSkinPhasesIn: self
]

{ #category : #'*Toplo' }
BlSpace >> needInnerConfigurationPass: aBoolean [

	self skinPhasesManager needInnerConfigurationPass: aBoolean.
	aBoolean ifTrue: [ self requestNextPulse ]
]

{ #category : #'*Toplo' }
BlSpace >> needSkinInstallPass: aBoolean [

	self skinPhasesManager needSkinInstallPass: aBoolean.
	aBoolean ifTrue: [ self requestNextPulse ]
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
		  Toplo announcer weak
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
