Class {
	#name : #ToChoiceBoxItem,
	#superclass : #ToMenuItem,
	#traits : 'TToCheckable + TToCheckbox',
	#classTraits : 'TToCheckable classTrait + TToCheckbox classTrait',
	#category : #'Toplo-Widget-ChoiceBox'
}

{ #category : #'t - initialization dresser' }
ToChoiceBoxItem >> defaultDresser [

	^ ToBasicMenuItemDresser next: (ToChoiceBoxItemDresser next: ToTripletDresser new)
]

{ #category : #'as yet unclassified' }
ToChoiceBoxItem >> initialize [

	super initialize.
	self initializeCheckable.
	self whenClickedDo: [ self switchToNextState ] 
]
