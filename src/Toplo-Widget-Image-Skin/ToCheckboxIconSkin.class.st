Class {
	#name : #ToCheckboxIconSkin,
	#superclass : #ToCheckableButtonIconSkin,
	#category : #'Toplo-Widget-Image-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToCheckboxIconSkin >> geometryIn: anElement [

	^ BlRoundedRectangleGeometry cornerRadius: 3
]
