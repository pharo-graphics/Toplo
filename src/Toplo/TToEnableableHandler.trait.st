Trait {
	#name : #TToEnableableHandler,
	#instVars : [
		'enabledHandler',
		'disabledHandler'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - enableable handler - events handling' }
TToEnableableHandler >> disabledEvent: anEvent in: anElement [
]

{ #category : #'t - enableable handler - events handling' }
TToEnableableHandler >> enabledEvent: anEvent in: anElement [
]

{ #category : #'t - enableable handler - install/uninstall hook' }
TToEnableableHandler >> onInstalledEnableableHandlingIn: anElement [

	enabledHandler := BlEventHandler on: ToWidgetEnabledEvent do: [ :event | self enabledEvent: event in: anElement ].
	disabledHandler := BlEventHandler on: ToWidgetDisabledEvent do: [ :event | self disabledEvent: event in: anElement ].
	
	anElement addEventHandler: enabledHandler.
	anElement addEventHandler: disabledHandler
]

{ #category : #'t - enableable handler - install/uninstall hook' }
TToEnableableHandler >> onUninstalledEnableableHandlingIn: anElement [

	anElement removeEventHandler: enabledHandler.
	anElement removeEventHandler: disabledHandler.
	enabledHandler := nil.
	disabledHandler := nil
]
