Class {
	#name : #ToChoiceBoxMenuItem,
	#superclass : #ToMenuItem,
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
	self initializeCheckable.
	self whenClickedDo: [ self switchToNextState ] 
]
