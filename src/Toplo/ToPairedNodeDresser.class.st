Class {
	#name : #ToPairedNodeDresser,
	#superclass : #ToNodeDresser,
	#instVars : [
		'backgroundBackup',
		'selectionAddedHandler',
		'selectionRemovedHandler'
	],
	#category : #'Toplo-Core-Node'
}

{ #category : #'api - install/uninstall  hook' }
ToPairedNodeDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	selectionAddedHandler := BlEventHandler
		                         on: ToListSelectionDecorationAddedEvent
		                         do: [ :event | self selectionDecorationAddedIn: anElement ].
	selectionRemovedHandler := BlEventHandler
		                           on: ToListSelectionDecorationRemovedEvent
		                           do: [ :event | self selectionDecorationRemovedIn: anElement ].
	anElement addEventHandler: selectionAddedHandler.
	anElement addEventHandler: selectionRemovedHandler.

]

{ #category : #'api - install/uninstall  hook' }
ToPairedNodeDresser >> selectionDecorationAddedIn: anElement [

	backgroundBackup := anElement background.
	anElement background: Color transparent.

]

{ #category : #'api - install/uninstall  hook' }
ToPairedNodeDresser >> selectionDecorationRemovedIn: anElement [

	backgroundBackup ifNotNil: [ anElement background: backgroundBackup ]
]

{ #category : #'api - install/uninstall  hook' }
ToPairedNodeDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
	anElement removeEventHandler: selectionAddedHandler.
	anElement removeEventHandler: selectionRemovedHandler.

]
