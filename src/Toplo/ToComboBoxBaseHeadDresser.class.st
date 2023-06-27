Class {
	#name : #ToComboBoxBaseHeadDresser,
	#superclass : #ToGeneralButtonDresser,
	#instVars : [
		'addedToParentHandler',
		'removedFromParentHandler',
		'comboBox'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToComboBoxBaseHeadDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	addedToParentHandler := BlEventHandler on: BlElementAddedToParentEvent do: [ self whenAdded: anElement ].
	removedFromParentHandler := BlEventHandler on: BlElementRemovedFromParentEvent do: [ self whenRemoved: anElement ].
	anElement addEventHandler: addedToParentHandler.
	anElement addEventHandler: removedFromParentHandler.

]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxBaseHeadDresser >> listElementRequestFocus [

	comboBox listElementRequestFocus
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxBaseHeadDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: addedToParentHandler.
	anElement removeEventHandler: removedFromParentHandler.

	super uninstallEventListenersIn: anElement.

]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxBaseHeadDresser >> whenAdded: anElement [

	comboBox := anElement parent.

]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxBaseHeadDresser >> whenRemoved: anElement [

	comboBox := nil

]
