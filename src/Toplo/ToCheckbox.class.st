Class {
	#name : #ToCheckbox,
	#superclass : #ToButton,
	#traits : 'TToCheckableWidgetWithIndeterminate',
	#classTraits : 'TToCheckableWidgetWithIndeterminate classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - initialization dresser' }
ToCheckbox >> defaultDresser [

	^ ToCheckBoxDresser new
]
