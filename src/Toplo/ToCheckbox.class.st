Class {
	#name : #ToCheckbox,
	#superclass : #ToButton,
	#traits : 'TToCheckableWidget + TToCheckableWidgetWithIndeterminate',
	#classTraits : 'TToCheckableWidget classTrait + TToCheckableWidgetWithIndeterminate classTrait',
	#instVars : [
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

	^ ToCheckBoxDresser new
]

{ #category : #'t - toggle group' }
ToCheckbox >> group [

	^ group
]

{ #category : #'t - toggle group' }
ToCheckbox >> group: aToggleGroup [

	group := aToggleGroup
]
