Class {
	#name : #ToRadioButtonDresser,
	#superclass : #ToCheckBoxDresser,
	#category : #'Toplo-Widget-Button'
}

{ #category : #'api - install/uninstall  hook' }
ToRadioButtonDresser >> defaultCheckedIconImage [

	^ super defaultCheckedIconImage
		  geometry: BlEllipseGeometry new;
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToRadioButtonDresser >> defaultIndeterminateIconImage [

	^ super defaultIndeterminateIconImage
		  geometry: BlEllipseGeometry new;
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToRadioButtonDresser >> defaultUncheckedIconImage [

	^ super defaultUncheckedIconImage
		  geometry: BlEllipseGeometry new;
		  yourself
]
