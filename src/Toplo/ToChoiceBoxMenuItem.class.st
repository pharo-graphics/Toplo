Class {
	#name : #ToChoiceBoxMenuItem,
	#superclass : #ToButtonMenuItem,
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#category : #'Toplo-Widget-ChoiceBox'
}

{ #category : #testing }
ToChoiceBoxMenuItem >> canSwitchToNextState [

	^ super canSwitchToNextState and: [ 
		  self group isNil or: [ self group canSwitchToNextState: self  ] ]
]

{ #category : #'t - initialization dresser' }
ToChoiceBoxMenuItem >> defaultDresser [

	^ ToBasicMenuItemDresser next: (ToChoiceBoxMenuItemDresser new)
]

{ #category : #'as yet unclassified' }
ToChoiceBoxMenuItem >> initialize [

	super initialize.
	self whenClickedDo: [ self switchToNextState ] 
]
