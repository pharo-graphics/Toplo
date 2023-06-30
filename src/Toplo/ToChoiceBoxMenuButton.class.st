Class {
	#name : #ToChoiceBoxMenuButton,
	#superclass : #ToButtonMenuItem,
	#traits : 'TToMenuItemHolder + TToMenuWindowModel',
	#classTraits : 'TToMenuItemHolder classTrait + TToMenuWindowModel classTrait',
	#category : #'Toplo-Widget-ChoiceBox'
}

{ #category : #'t - initialization dresser' }
ToChoiceBoxMenuButton >> defaultDresser [

	^ ToBasicMenuItemDresser next: (ToMenuWindowModelDresser next: (ToChoiceBoxMenuButtonDresser new))
]

{ #category : #initialization }
ToChoiceBoxMenuButton >> initialize [

	super initialize.

	self initializeMenuItemHolder.
	self initializeMenuWindowModel

]

{ #category : #window }
ToChoiceBoxMenuButton >> menuWindow [

	^ menuWindow 
]
