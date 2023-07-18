Class {
	#name : #ToCheckBoxDresser,
	#superclass : #ToGeneralButtonDresser,
	#instVars : [
		'checkedIcon',
		'indeterminateIcon',
		'uncheckedIcon',
		'checkableHandler'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'events handling' }
ToCheckBoxDresser >> clicked: anElement [

	" ask the button, my checkableHandler (see onInstalledIn:) with send the look event so don't send to super to avoid unnecessary change "
	anElement switchToNextState
]

{ #category : #'api - install/uninstall  hook' }
ToCheckBoxDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	checkableHandler := BlEventHandler on: ToCheckableCheckEvent do: [ :event | anElement dispatchEvent: ToClickLookEvent new ].
	anElement addEventHandler: checkableHandler
]

{ #category : #'api - install/uninstall  hook' }
ToCheckBoxDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement removeEventHandler: checkableHandler
]
