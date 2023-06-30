Class {
	#name : #ToDefaultImageSkin,
	#superclass : #ToThemeImageSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Image'
}

{ #category : #built }
ToDefaultImageSkin class >> type [ 

	^#default
]

{ #category : #built }
ToDefaultImageSkin >> builtForeground [

	^ self theme colorImage
]
