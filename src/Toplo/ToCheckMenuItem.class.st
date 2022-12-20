Class {
	#name : #ToCheckMenuItem,
	#superclass : #ToButtonMenuItem,
	#traits : 'TToCheckableWidget + TToCheckableWidgetWithIndeterminate',
	#classTraits : 'TToCheckableWidget classTrait + TToCheckableWidgetWithIndeterminate classTrait',
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
