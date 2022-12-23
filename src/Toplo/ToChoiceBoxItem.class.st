Class {
	#name : #ToChoiceBoxItem,
	#superclass : #ToButtonMenuItem,
	#traits : 'TToCheckableWidget',
	#classTraits : 'TToCheckableWidget classTrait',
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
