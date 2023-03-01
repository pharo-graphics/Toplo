Class {
	#name : #ToComboBoxHeadDresser,
	#superclass : #ToGeneralButtonDresser,
	#instVars : [
		'addedToParentHandler',
		'removedFromParentHandler'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	addedToParentHandler := BlEventHandler on: BlElementAddedToParentEvent do: [ self whenAddedToParent: anElement ].
	removedFromParentHandler := BlEventHandler on: BlElementRemovedFromParentEvent do: [ self whenRemovedFromParent: anElement ].
	anElement addEventHandler: addedToParentHandler.
	anElement addEventHandler: removedFromParentHandler
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement padding: (BlInsets top: 2 left: 5 bottom: 2 right: 4 ).
	anElement constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ]
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
	anElement removeEventHandler: addedToParentHandler.
	anElement removeEventHandler: removedFromParentHandler.
	mouseDownHandler ifNotNil: [ anElement removeEventHandler: mouseDownHandler ].
	addedToParentHandler := nil.
	removedFromParentHandler := nil.
	mouseDownHandler := nil
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> whenAddedToParent: anElement [

	| combo |
	combo := anElement parent.
	mouseDownHandler := (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :evt | combo popupOrCloseEvent: evt ]).
	anElement addEventHandler: mouseDownHandler
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> whenRemovedFromParent: anElement [

	anElement removeEventHandler: mouseDownHandler.
	mouseDownHandler := nil
]
