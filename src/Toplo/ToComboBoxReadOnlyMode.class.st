Class {
	#name : #ToComboBoxReadOnlyMode,
	#superclass : #ToComboBoxMode,
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #accessing }
ToComboBoxReadOnlyMode >> beListAutocompleteIn: aComboBox [

	self error: 'Invalid configuration'
]

{ #category : #initialization }
ToComboBoxReadOnlyMode >> defaultHeadElementIn: aComboBox [

	^ ToSelectOnlyComboBoxHead new
		  vFitContent;
		  hMatchParent;
		  yourself
]

{ #category : #accessing }
ToComboBoxReadOnlyMode >> saveEditingInList: aBoolean in: aComboBox [

	self error: 'Invalid configuration'
]

{ #category : #accessing }
ToComboBoxReadOnlyMode >> selectIndex: anIndex in: aComboBox [

	super selectIndex: anIndex in: aComboBox.
	aComboBox listElement ensureSelectIndex: anIndex
]
