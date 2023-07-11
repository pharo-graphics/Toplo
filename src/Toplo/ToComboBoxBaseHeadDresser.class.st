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
ToComboBoxBaseHeadDresser >> whenAddedToParent: anElement [

	super whenAddedToParent: anElement.
	comboBox := anElement parent.

]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxBaseHeadDresser >> whenRemovedFromParent: anElement [

	comboBox := nil.
	super whenRemovedFromParent: anElement.


]
