Class {
	#name : #ToComboBoxHead,
	#superclass : #ToGeneralButton,
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #accessing }
ToComboBoxHead >> contentElement: anElement [

	self firstChild first: anElement
]

{ #category : #'t - initialization dresser' }
ToComboBoxHead >> defaultDresser [

	^ ToComboBoxHeadDresser new
]
