Class {
	#name : 'ToComboBoxReadOnlyMode',
	#superclass : 'ToComboBoxMode',
	#category : 'Toplo-Widget-ComboBox',
	#package : 'Toplo-Widget-ComboBox'
}

{ #category : 'accessing' }
ToComboBoxReadOnlyMode >> beListAutocompleteIn: aComboBox [

	self error: 'Invalid configuration'
]

{ #category : 'initialization' }
ToComboBoxReadOnlyMode >> defaultHeadElementIn: aComboBox [

	^ ToSelectOnlyComboBoxHead new
		  comboBox: aComboBox;
		  yourself
]

{ #category : 'accessing' }
ToComboBoxReadOnlyMode >> selectIndex: anIndex in: aComboBox [

	super selectIndex: anIndex in: aComboBox.
	aComboBox listElement ensureSelectIndex: anIndex
]

{ #category : 'transaction hook' }
ToComboBoxReadOnlyMode >> whenSaveAcceptedDo: aBlock in: aComboBox [

		self error: 'Invalid usage'
]

{ #category : 'transaction hook' }
ToComboBoxReadOnlyMode >> whenSaveDeniedDo: aBlock in: aComboBox [

		self error: 'Invalid usage'
]

{ #category : 'transaction hook' }
ToComboBoxReadOnlyMode >> whenTextEditedDo: aBlock in: aComboBox [

		self error: 'Invalid usage'
]

{ #category : 'transaction hook' }
ToComboBoxReadOnlyMode >> withSaveCapabilityIn: aComboBox [

		self error: 'Invalid usage'
]
