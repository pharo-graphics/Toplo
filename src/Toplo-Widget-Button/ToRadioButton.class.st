Class {
	#name : #ToRadioButton,
	#superclass : #ToCheckbox,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #skin }
ToRadioButton >> defaultBlankCheckboxImage [

	| im |
	im := super defaultBlankCheckboxImage.
	im geometry: BlCircleGeometry new.
	^ im
]

{ #category : #skin }
ToRadioButton >> installRawStyle [ 

	super installRawStyle.
	self icon geometry: BlCircleGeometry new.
]
