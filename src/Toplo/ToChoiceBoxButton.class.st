Class {
	#name : #ToChoiceBoxButton,
	#superclass : #ToButtonMenuItem,
	#traits : 'TToMenuItemHolder + TToMenuWindowModel',
	#classTraits : 'TToMenuItemHolder classTrait + TToMenuWindowModel classTrait',
	#category : #'Toplo-Widget-ChoiceBox'
}

{ #category : #'t - initialization dresser' }
ToChoiceBoxButton >> defaultDresser [

	^ ToBasicMenuItemDresser next: (ToMenuWindowModelDresser next: (ToChoiceBoxButtonDresser new))
]

{ #category : #initialization }
ToChoiceBoxButton >> initialize [

	super initialize.

	self initializeMenu.
	self initializeMenuWindowModel


]
