Class {
	#name : #ToChoiceBoxItem,
	#superclass : #ToButtonMenuItem,
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#category : #'Toplo-Widget-ChoiceBox'
}

{ #category : #'t - initialization dresser' }
ToChoiceBoxItem >> defaultDresser [

	^ ToBasicMenuItemDresser next: (ToChoiceBoxItemDresser next: ToMenuItemRowDresser new)
]

{ #category : #initialization }
ToChoiceBoxItem >> initialize [

	super initialize.
	self whenClickedDo: [ self switchToNextState ]
]
