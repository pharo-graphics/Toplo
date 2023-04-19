Class {
	#name : #ToPairedNodeDresser,
	#superclass : #ToNodeDresser,
	#instVars : [
		'backgroundBackup',
		'selectionRemovedHandler',
		'selectionBackgroundChangedHandler'
	],
	#category : #'Toplo-Core-Node'
}

{ #category : #'api - install/uninstall  hook' }
ToPairedNodeDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	selectionBackgroundChangedHandler := BlEventHandler
		                         on: ToListPrimarySelectionBackgroundChangedEvent
		                         do: [ :event | self selectionBackgroundChangedIn: anElement ].
	selectionRemovedHandler := BlEventHandler
		                           on: ToListPrimarySelectionRemovedEvent
		                           do: [ :event | self selectionRemovedIn: anElement ].
	anElement addEventHandler: selectionBackgroundChangedHandler.
	anElement addEventHandler: selectionRemovedHandler.

]

{ #category : #'api - install/uninstall  hook' }
ToPairedNodeDresser >> selectionBackgroundChangedIn: anElement [

	backgroundBackup ifNil: [
		backgroundBackup := anElement background.
		anElement background: Color transparent ]
]

{ #category : #'api - install/uninstall  hook' }
ToPairedNodeDresser >> selectionRemovedIn: anElement [

	backgroundBackup ifNotNil: [
		anElement background: backgroundBackup.
		backgroundBackup := nil ]
]

{ #category : #'api - install/uninstall  hook' }
ToPairedNodeDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
	anElement removeEventHandler: selectionBackgroundChangedHandler.
	anElement removeEventHandler: selectionRemovedHandler.

]
