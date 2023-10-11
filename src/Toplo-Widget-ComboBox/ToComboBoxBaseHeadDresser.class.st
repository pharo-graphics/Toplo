Class {
	#name : #ToComboBoxBaseHeadDresser,
	#superclass : #Object,
	#instVars : [
		'comboBox'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToComboBoxBaseHeadDresser >> listElementRequestFocus [

	comboBox listElementRequestFocus
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
