Class {
	#name : #ToRadioMenuItem,
	#superclass : #ToCheckMenuItem,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'t - initialization dresser' }
ToRadioMenuItem >> defaultDresser [

	^ ToBasicMenuItemDresser next: (ToRadioButtonDresser next: ToMenuItemRowDresser new)
]
