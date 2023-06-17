Class {
	#name : #ToComboBoxSelectOnlyMode,
	#superclass : #ToComboBoxMode,
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #initialization }
ToComboBoxSelectOnlyMode >> defaultHeadElementIn: aComboBox [

	^ ToSelectOnlyComboBoxHead new
		  vFitContent;
		  hMatchParent;
		  yourself
]

{ #category : #accessing }
ToComboBoxSelectOnlyMode >> selectIndex: anIndex in: aComboBox [

	super selectIndex: anIndex in: aComboBox.
	aComboBox listElement ensureSelectIndex: anIndex
]
