Class {
	#name : #ToCheckboxIconSkin,
	#superclass : #ToCheckableButtonIconSkin,
	#category : #'Toplo-Widget-Image-Skins'
}

{ #category : #'api - install/uninstall  hook' }
ToCheckboxIconSkin >> geometryIn: anElement [

	^ BlRoundedRectangleGeometry cornerRadius: 3
]
