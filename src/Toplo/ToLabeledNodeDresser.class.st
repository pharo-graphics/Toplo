Class {
	#name : #ToLabeledNodeDresser,
	#superclass : #ToNodeDresser,
	#instVars : [
		'selected',
		'selectionDecoration',
		'backgroundBackup',
		'selectionAddedHandler',
		'selectionRemovedHandler'
	],
	#category : #'Toplo-Core-Node'
}

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	anElement whenLabelChangedDo: [ :curr :prev | self installNewLabel: curr previous: prev in: anElement].
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
ToLabeledNodeDresser >> installNewLabel: curr previous: prev in: anElement [

	prev ifNotNil: [ prev undress ].
	curr addDresser: (ToLabelInNodeDresser new node: anElement; yourself)
]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> selectionDecorationAddedIn: anElement [

	backgroundBackup := anElement background.
	anElement background: Color transparent.

]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> selectionDecorationRemovedIn: anElement [

	backgroundBackup ifNotNil: [ anElement background: backgroundBackup ]
]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
	anElement label ifNotNil: [:l | l undress].
	anElement removeEventHandler: selectionAddedHandler.
	anElement removeEventHandler: selectionRemovedHandler.

]
