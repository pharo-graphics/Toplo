Class {
	#name : #ToCheckNodeDresser,
	#superclass : #ToNodeDresser,
	#instVars : [
		'checkedIcon',
		'indeterminateIcon',
		'uncheckedIcon',
		'selectedHandler',
		'deselectedHandler'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #'api - install/uninstall  hook' }
ToCheckNodeDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.

	selectedHandler := BlEventHandler on: ToNodeHolderSelectedEvent do: [ :event | anElement check ].
	deselectedHandler := BlEventHandler on: ToNodeHolderDeselectedEvent do: [ :event | anElement uncheck ].
	
	anElement addEventHandler: selectedHandler.
	anElement addEventHandler: deselectedHandler.

]

{ #category : #'api - install/uninstall  hook' }
ToCheckNodeDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToCheckNodeDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.

]

{ #category : #'api - install/uninstall  hook' }
ToCheckNodeDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: selectedHandler.
	anElement removeEventHandler: deselectedHandler.
	
	super uninstallEventListenersIn: anElement.


]
