Class {
	#name : #ToCheckbox,
	#superclass : #ToButton,
	#traits : 'TToCheckableWidget + TToCheckableWidgetWithIndeterminate',
	#classTraits : 'TToCheckableWidget classTrait + TToCheckableWidgetWithIndeterminate classTrait',
	#instVars : [
		'hasIndeterminateState',
		'group'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #testing }
ToCheckbox >> canSwitchToNextState [

	^ super canSwitchToNextState and: [ 
		  self group isNil or: [ self isUnchecked ] ]
]

{ #category : #'t - initialization dresser' }
ToCheckbox >> defaultDresser [

	^ ToButtonDresser next: ToCheckBoxDresser new
]

{ #category : #'t - toggle group' }
ToCheckbox >> group [

	^ group
]

{ #category : #'t - toggle group' }
ToCheckbox >> group: aToggleGroup [

	group := aToggleGroup
]

{ #category : #'t - checking accessing state' }
ToCheckbox >> hasIndeterminateState [

	^ hasIndeterminateState ifNil: [ hasIndeterminateState := false ]
]

{ #category : #'t - checking accessing state' }
ToCheckbox >> hasIndeterminateState: aBoolean [

	aBoolean = self hasIndeterminateState ifTrue: [ ^ self ].
	hasIndeterminateState := aBoolean.
	self announce: 	(ToStatesDefinitionChangedAnnouncement new widget: self)

]
