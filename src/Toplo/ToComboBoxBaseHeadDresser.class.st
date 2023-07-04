Class {
	#name : #ToComboBoxBaseHeadDresser,
	#superclass : #ToGeneralButtonDresser,
	#instVars : [
		'comboBox'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToComboBoxBaseHeadDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.

]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxBaseHeadDresser >> listElementRequestFocus [

	comboBox listElementRequestFocus
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxBaseHeadDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.

]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxBaseHeadDresser >> whenAdded: anElement [

	super whenAdded: anElement.
	comboBox := anElement parent.

]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxBaseHeadDresser >> whenRemoved: anElement [

	comboBox := nil.
	super whenRemoved: anElement.


]
