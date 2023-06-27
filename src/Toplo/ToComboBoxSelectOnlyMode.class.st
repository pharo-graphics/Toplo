Class {
	#name : #ToComboBoxSelectOnlyMode,
	#superclass : #ToComboBoxMode,
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #initialization }
ToComboBoxSelectOnlyMode >> defaultHeadElement [

	^ ToSelectOnlyComboBoxHead new
		  vFitContent;
		  hMatchParent;
		  yourself
]
