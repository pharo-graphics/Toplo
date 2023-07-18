Class {
	#name : #ToRadioButtonDresserDep,
	#superclass : #ToCheckBoxDresser,
	#category : #'Toplo-Widget-Button'
}

{ #category : #'api - install/uninstall  hook' }
ToRadioButtonDresserDep >> defaultCheckedIconImage [

	^ super defaultCheckedIconImage
		  in: [ :im | im innerImage geometry: BlEllipseGeometry new ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToRadioButtonDresserDep >> defaultIndeterminateIconImage [

	^ super defaultIndeterminateIconImage
		  in: [ :im | im innerImage geometry: BlEllipseGeometry new ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToRadioButtonDresserDep >> defaultUncheckedIconImage [

	^ super defaultUncheckedIconImage
		  in: [ :im | im innerImage geometry: BlEllipseGeometry new ];
		  yourself
]
