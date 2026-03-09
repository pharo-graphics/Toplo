Class {
	#name : #ToCheckbox,
	#superclass : #ToToggleButton,
	#classTraits : 'TToCheckable classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #skin }
ToCheckbox >> newRawSkin [ 

	^ ToCheckboxSkin new
]
