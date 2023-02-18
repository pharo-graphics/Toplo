Class {
	#name : #ToComboBoxButton,
	#superclass : #ToButton,
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'t - initialization dresser' }
ToComboBoxButton >> defaultDresser [

	^ super defaultDresser next: ToComboBoxButtonDresser new
]
