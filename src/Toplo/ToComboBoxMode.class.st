Class {
	#name : #ToComboBoxMode,
	#superclass : #Object,
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #initialization }
ToComboBoxMode >> defaultHeadElement [
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
