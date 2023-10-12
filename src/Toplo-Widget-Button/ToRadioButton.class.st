Class {
	#name : #ToRadioButton,
	#superclass : #ToCheckbox,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #initialization }
ToRadioButton >> defaultBlankCheckboxImage [

	^ super defaultBlankCheckboxImage
		  geometry: BlCircleGeometry new;
		  yourself
]
