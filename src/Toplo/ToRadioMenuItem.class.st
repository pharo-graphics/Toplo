Class {
	#name : #ToRadioMenuItem,
	#superclass : #ToCheckMenuItem,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'t - initialization dresser' }
ToRadioMenuItem >> defaultDresser [

	^ ToBasicMenuItemDresser next: ToCheckableButtonDresser new
]

{ #category : #'t - skinable - initialization' }
ToRadioMenuItem >> defaultSkin [ 

	^ ToRadioButtonItemSkin new
]
