Class {
	#name : #ToCheckMenuItem,
	#superclass : #ToButtonMenuItem,
	#traits : 'TToCheckable + TToCheckableWithIndeterminate',
	#classTraits : 'TToCheckable classTrait + TToCheckableWithIndeterminate classTrait',
	#category : #'Toplo-Widget-Menu'
}

{ #category : #testing }
ToCheckMenuItem >> canSwitchToNextState [

	^ self currentState notNil and: [ 
		  self group isNil or: [ self group canSwitchToNextState: self  ] ]
]

{ #category : #'t - initialization dresser' }
ToCheckMenuItem >> defaultDresser [

	^ ToBasicMenuItemDresser next: (ToCheckBoxDresser new)
]

{ #category : #initialization }
ToCheckMenuItem >> initialize [

	super initialize.
	self whenClickedDo: [ self switchToNextState ]
]
