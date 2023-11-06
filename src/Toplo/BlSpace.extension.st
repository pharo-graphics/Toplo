Extension { #name : 'BlSpace' }

{ #category : '*Toplo' }
BlSpace >> allowSkinPhases [

	^ self skinPhasesManager allowSkinPhases
]

{ #category : '*Toplo' }
BlSpace >> allowSkinPhases: aBoolean [

	" useful for testing. tests may want to run phases programmatically"
	self skinPhasesManager allowSkinPhases: aBoolean
]

{ #category : '*Toplo' }
BlSpace >> applySkinInstaller [

	self skinPhasesManager applySkinInstaller
]

{ #category : '*Toplo' }
BlSpace >> flushSkinStates [
	
	self skinPhasesManager flushSkinStates
]

{ #category : '*Toplo' }
BlSpace >> installSkinPhases [

	self skinPhasesManager onInstalledIn: self
]

{ #category : '*Toplo' }
BlSpace >> skinInstallerSetIn: anElement [

	self skinPhasesManager skinInstallerSetIn: anElement
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

{ #category : '*Toplo' }
BlSpace >> styleDirtyIn: anElement [

	self skinPhasesManager styleDirtyIn: anElement
]

{ #category : '*Toplo-LookAndFeel' }
BlSpace >> toTheme [

	^ self root toTheme
]

{ #category : '*Toplo-LookAndFeel' }
BlSpace >> toTheme: aTheme [

	self root toTheme: aTheme
]

{ #category : '*Toplo' }
BlSpace >> uninstallSkinPhases [

	self skinPhasesManager onUninstalledIn: self
]
