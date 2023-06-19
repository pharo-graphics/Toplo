Class {
	#name : #ToComboBoxEditableMode,
	#superclass : #ToComboBoxMode,
	#instVars : [
		'listAutocomplete',
		'listAutocompleteDresser'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #accessing }
ToComboBoxEditableMode >> beListAutocompleteIn: aComboBox [

	listAutocompleteDresser ifNotNil: [ ^ self ].
	listAutocompleteDresser := ToComboBoxListAutocompleteHeadDresser new comboBox: aComboBox.
	aComboBox headElement addDresser: listAutocompleteDresser
]

{ #category : #initialization }
ToComboBoxEditableMode >> defaultHeadElementIn: aComboBox [

	^ ToEditableComboBoxHead new
		  vFitContent;
		  hMatchParent;
		  yourself
]

{ #category : #initialization }
ToComboBoxEditableMode >> initialize [ 

	super initialize.
	listAutocomplete := true
]

{ #category : #accessing }
ToComboBoxEditableMode >> listAutocomplete [

	^ listAutocomplete 
]

{ #category : #accessing }
ToComboBoxEditableMode >> listAutocomplete: aBoolean [

	listAutocomplete := aBoolean 
]

{ #category : #initialization }
ToComboBoxEditableMode >> saveEditingInList: aBoolean in: aComboBox [

	^ aComboBox headElement saveEditingInList: aBoolean

]
