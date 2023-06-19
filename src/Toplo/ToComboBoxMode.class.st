Class {
	#name : #ToComboBoxMode,
	#superclass : #Object,
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #accessing }
ToComboBoxMode >> beListAutocompleteIn: aComboBox [

	self subclassResponsibility 
]

{ #category : #initialization }
ToComboBoxMode >> defaultHeadElementIn: aComboBox [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToComboBoxMode >> selectIndex: anIndex in: aComboBox [

	anIndex isZero ifTrue: [
		aComboBox listElement deselectAll.
		^ aComboBox headElement noDataSelected ].
	aComboBox headElement
		selectData: (aComboBox data at: anIndex)
		in: aComboBox
]

{ #category : #'transaction hook' }
ToComboBoxMode >> whenCancelRequestedDo: aBlock in: aComboBox [

	self subclassResponsibility 
]

{ #category : #'transaction hook' }
ToComboBoxMode >> whenSaveAcceptedDo: aBlock in: aComboBox [

	self subclassResponsibility 
]

{ #category : #'transaction hook' }
ToComboBoxMode >> whenSaveDeniedDo: aBlock in: aComboBox [

	self subclassResponsibility 
]

{ #category : #'transaction hook' }
ToComboBoxMode >> whenSaveRequestedDo: aBlock in: aComboBox [

	self subclassResponsibility 
]

{ #category : #'transaction hook' }
ToComboBoxMode >> whenTextEditedDo: aBlock in: aComboBox [

	self subclassResponsibility 
]

{ #category : #'transaction hook' }
ToComboBoxMode >> withSaveCapabilityIn: aComboBox [

	self subclassResponsibility 
]
