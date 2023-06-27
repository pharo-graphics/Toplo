Class {
	#name : #ToComboBoxEditableMode,
	#superclass : #ToComboBoxMode,
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #initialization }
ToComboBoxEditableMode >> defaultHeadElement [

	^ ToEditableComboBoxHead new
		  vFitContent;
		  hMatchParent;
		  yourself
]
