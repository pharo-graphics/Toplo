Class {
	#name : #ToRadioButtonDresser,
	#superclass : #ToCheckBoxDresser,
	#category : #'Toplo-Widget-Button'
}

{ #category : #'api - install/uninstall  hook' }
ToRadioButtonDresser >> defaultCheckedIconImage [

	^ super defaultCheckedIconImage
		  in: [ :im | im innerImage geometry: BlEllipseGeometry new ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToRadioButtonDresser >> defaultIndeterminateIconImage [

	^ super defaultIndeterminateIconImage
		  in: [ :im | im innerImage geometry: BlEllipseGeometry new ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToRadioButtonDresser >> defaultUncheckedIconImage [

	^ super defaultUncheckedIconImage
		  in: [ :im | im innerImage geometry: BlEllipseGeometry new ];
		  yourself
]
