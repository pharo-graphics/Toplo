Class {
	#name : #ToCheckbox,
	#superclass : #ToButton,
	#traits : 'TToCheckableWidget',
	#classTraits : 'TToCheckableWidget classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - initialization dresser' }
ToCheckbox >> defaultDresser [

	^ ToCheckBoxDresser new
]

{ #category : #initialization }
ToCheckbox >> initialize [

	super initialize.
	self initializeAsCheckable
]
