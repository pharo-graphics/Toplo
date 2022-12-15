Class {
	#name : #ToRadioButton,
	#superclass : #ToCheckbox,
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - initialization dresser' }
ToRadioButton >> defaultDresser [

	^ ToButtonDresser next: ToRadioButtonDresser new
]
