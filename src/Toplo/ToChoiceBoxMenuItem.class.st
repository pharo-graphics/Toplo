Class {
	#name : #ToChoiceBoxMenuItem,
	#superclass : #ToButtonMenuItem,
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#category : #'Toplo-Widget-ChoiceBox'
}

{ #category : #'t - initialization dresser' }
ToChoiceBoxMenuItem >> defaultDresser [

	^ ToBasicMenuItemDresser next: (ToChoiceBoxMenuItemDresser new)
]

{ #category : #initialization }
ToChoiceBoxMenuItem >> initialize [

	super initialize.
	self whenClickedDo: [ self isChecked ifFalse: [ self switchToNextState ] ]
]
