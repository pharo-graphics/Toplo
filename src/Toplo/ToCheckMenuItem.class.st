Class {
	#name : #ToCheckMenuItem,
	#superclass : #ToButtonMenuItem,
	#traits : 'TToCheckableWidget + TToCheckableWidgetWithIndeterminate',
	#classTraits : 'TToCheckableWidget classTrait + TToCheckableWidgetWithIndeterminate classTrait',
	#instVars : [
		'hasIndeterminateState',
		'group'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #testing }
ToCheckMenuItem >> canSwitchToNextState [

	^ self currentState notNil and: [ 
		  self group isNil or: [ self isUnchecked ] ]
]

{ #category : #'t - initialization dresser' }
ToCheckMenuItem >> defaultDresser [

	^ ToBasicMenuItemDresser next: (ToCheckBoxDresser next: ToMenuItemRowDresser new)
]

{ #category : #'t - toggle group' }
ToCheckMenuItem >> group [

	^ group
]

{ #category : #'t - toggle group' }
ToCheckMenuItem >> group: aToggleGroup [

	group := aToggleGroup
]

{ #category : #'t - checking accessing state' }
ToCheckMenuItem >> hasIndeterminateState [

	^ hasIndeterminateState ifNil: [ hasIndeterminateState := false ]
]

{ #category : #'t - checking accessing state' }
ToCheckMenuItem >> hasIndeterminateState: aBoolean [

	aBoolean = self hasIndeterminateState ifTrue: [ ^ self ].
	hasIndeterminateState := aBoolean.
	self announce: 	(ToStatesDefinitionChangedAnnouncement new widget: self)

]
