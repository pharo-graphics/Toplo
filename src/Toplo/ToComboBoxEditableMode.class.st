Class {
	#name : #ToComboBoxEditableMode,
	#superclass : #ToComboBoxMode,
	#instVars : [
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

{ #category : #'transaction hook' }
ToComboBoxEditableMode >> whenSaveAcceptedDo: aBlock in: aComboBox [

	aComboBox headElement whenSaveAcceptedDo: aBlock 
]

{ #category : #'transaction hook' }
ToComboBoxEditableMode >> whenSaveDeniedDo: aBlock in: aComboBox [

	aComboBox headElement whenSaveDeniedDo: aBlock 
]

{ #category : #'transaction hook' }
ToComboBoxEditableMode >> whenTextEditedDo: aBlock in: aComboBox [

	aComboBox headElement whenTextEditedDo: aBlock
]

{ #category : #'transaction hook' }
ToComboBoxEditableMode >> withSaveCapabilityIn: aComboBox [

	aComboBox headElement withSaveCapability
]
