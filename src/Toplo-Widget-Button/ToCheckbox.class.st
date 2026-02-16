Class {
	#name : #ToCheckbox,
	#superclass : #ToToggleButton,
	#classTraits : 'TToCheckable classTrait',
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #skin }
ToCheckbox >> newRawSkin [ 

	^ ToCheckboxSkin new
]
