Class {
	#name : #ToComboBoxHead,
	#superclass : #ToGeneralButton,
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'t - initialization dresser' }
ToComboBoxHead >> defaultDresser [

	^ super defaultDresser next: ToComboBoxHeadDresser new
]
