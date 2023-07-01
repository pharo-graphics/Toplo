Class {
	#name : #ToComboBoxBaseHeadDresser,
	#superclass : #ToGeneralButtonDresser,
	#instVars : [
		'removedFromParentHandler',
		'addInParentHandler',
		'comboBox'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToComboBoxBaseHeadDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	addInParentHandler := BlEventHandler on: BlElementAddedToParentEvent do: [ self whenAdded: anElement ].
	removedFromParentHandler := BlEventHandler on: BlElementRemovedFromParentEvent do: [ self whenRemoved: anElement ].
	anElement addEventHandler: addInParentHandler.
	anElement addEventHandler: removedFromParentHandler.

]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxBaseHeadDresser >> listElementRequestFocus [

	comboBox listElementRequestFocus
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxBaseHeadDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: removedFromParentHandler.
	anElement removeEventHandler: addInParentHandler.

	super uninstallEventListenersIn: anElement.

]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxBaseHeadDresser >> whenAdded: anElement [

	super whenAdded: anElement.
	comboBox := anElement parent.

]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxBaseHeadDresser >> whenRemoved: anElement [

	comboBox := nil

]
