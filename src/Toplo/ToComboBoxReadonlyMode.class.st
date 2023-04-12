Class {
	#name : #ToComboBoxReadonlyMode,
	#superclass : #ToComboBoxMode,
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #initialization }
ToComboBoxReadonlyMode >> defaultHeadElement [

	^ ToReadonlyComboBoxHead new
		  vFitContent;
		  hMatchParent;
		  yourself
]
