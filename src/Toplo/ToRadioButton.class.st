Class {
	#name : #ToRadioButton,
	#superclass : #ToCheckbox,
	#category : #'Toplo-Widget-Button'
}

{ #category : #initialization }
ToRadioButton >> checkedIconImage [

	^ super checkedIconImage
		  geometry: BlEllipseGeometry new;
		  yourself
]

{ #category : #initialization }
ToRadioButton >> inderterminateIconImage [

	^ super inderterminateIconImage
		  geometry: BlEllipseGeometry new;
		  yourself
]

{ #category : #initialization }
ToRadioButton >> uncheckedIconImage [

	^ super uncheckedIconImage
		  geometry: BlEllipseGeometry new;
		  yourself
]
