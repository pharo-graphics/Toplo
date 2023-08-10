Trait {
	#name : #TToEnableableHandler,
	#instVars : [
		'enabledHandler',
		'disabledHandler',
		'enablementHandler'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - enableable handler - events handling' }
TToEnableableHandler >> enablementEvent: anEvent in: anElement [
]

{ #category : #'t - enableable handler - install/uninstall hook' }
TToEnableableHandler >> onInstalledEnableableHandlingIn: anElement [

	enablementHandler := BlEventHandler
		                     on: ToEnablementChangedEvent
		                     do: [ :event | self enablementEvent: event in: anElement ].
	anElement addEventHandler: enablementHandler
]

{ #category : #'t - enableable handler - install/uninstall hook' }
TToEnableableHandler >> onUninstalledEnableableHandlingIn: anElement [

	anElement removeEventHandler: enablementHandler.
	enablementHandler := nil
]
