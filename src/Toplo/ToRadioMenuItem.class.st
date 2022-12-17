Class {
	#name : #ToRadioMenuItem,
	#superclass : #ToCheckMenuItem,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'t - initialization dresser' }
ToRadioMenuItem >> defaultDresser [

	^ ToMenuItemDresser next: ToRadioMenuItemDresser new
]
