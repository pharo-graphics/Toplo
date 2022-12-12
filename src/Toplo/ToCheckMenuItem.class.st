Class {
	#name : #ToCheckMenuItem,
	#superclass : #ToButtonMenuItem,
	#traits : 'TToWidgetWithState + TToCheckableWidget + TToCheckableWidgetWithIndeterminate',
	#classTraits : 'TToWidgetWithState classTrait + TToCheckableWidget classTrait + TToCheckableWidgetWithIndeterminate classTrait',
	#instVars : [
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

	^ ToMenuItemDresser next: ToCheckMenuItemDresser new
]

{ #category : #'t - toggle group' }
ToCheckMenuItem >> group [

	^ group
]

{ #category : #'t - toggle group' }
ToCheckMenuItem >> group: aToggleGroup [

	group := aToggleGroup
]
