Class {
	#name : #ToCheckbox,
	#superclass : #ToButton,
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - initialization dresser' }
ToCheckbox >> defaultDresser [

	^ ToCheckBoxDresser new
]

{ #category : #'t - skin accessing' }
ToCheckbox >> defaultSkin [ 

	^ ToCheckboxSkin new
]

{ #category : #initialization }
ToCheckbox >> initialize [

	super initialize.
	self initializeCheckable 
]
