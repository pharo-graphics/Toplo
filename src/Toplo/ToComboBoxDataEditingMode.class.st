Class {
	#name : #ToComboBoxDataEditingMode,
	#superclass : #ToComboBoxEditableMode,
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #initialization }
ToComboBoxDataEditingMode >> defaultHeadElement [

	^ ToDataEditingComboBoxHead new
		  vFitContent;
		  hMatchParent;
		  yourself
]
