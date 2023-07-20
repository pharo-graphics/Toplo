Class {
	#name : #ToCheckableButtonDresser,
	#superclass : #ToGeneralButtonDresser,
	#instVars : [
		'checkableHandler'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'api - install/uninstall  hook' }
ToCheckableButtonDresser >> checkEvent: anEvent in: anElement [
self flag: 'issue here, because checkEvent:in: can be send either because of a click or because the checkable as been checked programmatically'.
	anElement dispatchEvent: ToClickLookEvent new
]

{ #category : #'events handling' }
ToCheckableButtonDresser >> clicked: anElement [

	" ask the button, my checkableHandler (see onInstalledIn:) with send the click look event so don't send to super to avoid unnecessary change "
	anElement switchToNextState.
	self hoveredState: anElement 

]

{ #category : #'api - install/uninstall  hook' }
ToCheckableButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	checkableHandler := BlEventHandler on: ToCheckableCheckEvent do: [ :event | self checkEvent: event in: anElement ].
	anElement addEventHandler: checkableHandler
]

{ #category : #'api - install/uninstall  hook' }
ToCheckableButtonDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement removeEventHandler: checkableHandler
]
