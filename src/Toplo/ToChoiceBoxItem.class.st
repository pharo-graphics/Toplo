Class {
	#name : #ToChoiceBoxItem,
	#superclass : #ToMenuItem,
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#category : #'Toplo-Widget-ChoiceBox'
}

{ #category : #'t - initialization dresser' }
ToChoiceBoxItem >> defaultDresser [

	^ ToBasicMenuItemDresser next: (ToChoiceBoxItemDresser new)
]

{ #category : #initialization }
ToChoiceBoxItem >> initialize [

	super initialize.
	self initializeCheckable.
	self whenClickedDo: [ self switchToNextState ] 
]
