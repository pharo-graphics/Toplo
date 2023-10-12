Class {
	#name : #ToBeeSkin,
	#superclass : #ToStyleSheetSkin,
	#category : #'Toplo-Theme-Bee'
}

{ #category : #'api - install/uninstall  hook' }
ToBeeSkin >> onSkinInstalledIn: anElement [

	anElement initializeBeeStyle
]
