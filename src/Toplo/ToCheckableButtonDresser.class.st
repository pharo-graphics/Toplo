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

	anElement dispatchEvent: ToClickLookEvent new.
	anEvent current ifTrue: [self hoveredState: anElement]

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
