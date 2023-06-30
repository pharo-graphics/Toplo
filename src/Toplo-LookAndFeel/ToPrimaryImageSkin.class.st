Class {
	#name : #ToPrimaryImageSkin,
	#superclass : #ToThemeImageSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Image'
}

{ #category : #testing }
ToPrimaryImageSkin class >> type [

	^ #primary
]

{ #category : #built }
ToPrimaryImageSkin >> builtForeground [

	^ self theme colorImageLightSolid
]
