Extension { #name : #BlSpace }

{ #category : #'*Toplo' }
BlSpace >> applyAllEnqueuedStates [

	self phasesManager applyAllEnqueuedStatesIn: self
]

{ #category : #'*Toplo' }
BlSpace >> applyAllSkinInstallers [

	self phasesManager applyAllSkinInstallersIn: self
]

{ #category : #'*Toplo' }
BlSpace >> applyAllSkinPhases [

	self applyAllSkinInstallers.
	self applyAllEnqueuedStates.
]

{ #category : #'*Toplo' }
BlSpace >> applyAllWidgetConfigurations [

	self phasesManager applyAllConfigurationsIn: self
]

{ #category : #'*Toplo' }
BlSpace >> checkToploPhases [

	self phasesManager checkPhasesIn: self
]

{ #category : #'*Toplo' }
BlSpace >> isApplyingConfigurations [

	^ self phasesManager isApplyingConfigurations
]

{ #category : #'*Toplo' }
BlSpace >> needSkinInstallPass [

	^ self phasesManager needSkinInstallPass
]

{ #category : #'*Toplo' }
BlSpace >> needSkinInstallPass: aBoolean [

	self phasesManager needSkinInstallPass: aBoolean.
	aBoolean ifTrue: [ self requestNextPulse ]
]

{ #category : #'*Toplo' }
BlSpace >> needSkinStateApplicationPass: aBoolean [

	self phasesManager needSkinStateApplicationPass: aBoolean.
	aBoolean ifTrue: [ self requestNextPulse ]
]

{ #category : #'*Toplo' }
BlSpace >> nextConfigurationPass [

	^ self phasesManager nextConfigurationPass 
]

{ #category : #'*Toplo' }
BlSpace >> phasesManager [

	^ self userData at: #phasesManager ifAbsentPut: [ ToSpacePhasesManager new ]
]

{ #category : #'*Toplo' }
BlSpace >> requestNewConfigurationPass [

	self phasesManager requestNewConfigurationPass.
	self requestNextPulse 
]

{ #category : #'*Toplo' }
BlSpace >> requestSkinStateApplicationPass [

	self needSkinStateApplicationPass: true
]

{ #category : #'*Toplo-LookAndFeel' }
BlSpace >> resetToTheme [

	self toTheme: Toplo newDefaultThemeInstance
]

{ #category : #'*Toplo' }
BlSpace >> runningConfigurationPass [

	^ self phasesManager runningConfigurationPass 
]

{ #category : #'*Toplo' }
BlSpace >> startToploPhases [

	self phasesManager startPhasesIn: self
]

{ #category : #'*Toplo' }
BlSpace >> stopToploPhases [

	self phasesManager stopPhasesIn: self
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
