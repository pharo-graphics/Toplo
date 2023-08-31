Class {
	#name : #ToRadioButtonIconSkin,
	#superclass : #ToCheckableButtonIconSkin,
	#category : #'Toplo-Widget-Image-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToRadioButtonIconSkin >> geometryIn: anElement [

	^ BlCircleGeometry new
]
