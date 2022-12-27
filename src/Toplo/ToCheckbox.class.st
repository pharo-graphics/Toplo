Class {
	#name : #ToCheckbox,
	#superclass : #ToMultiStateButton,
	#traits : 'TToCheckable + TToCheckableWithIndeterminate',
	#classTraits : 'TToCheckable classTrait + TToCheckableWithIndeterminate classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #testing }
ToCheckbox >> canSwitchToNextState [

	^ super canSwitchToNextState and: [ 
		  self group isNil or: [ self isUnchecked ] ]
]

{ #category : #'t - initialization dresser' }
ToCheckbox >> defaultDresser [

	^ ToCheckBoxDresser new
]
