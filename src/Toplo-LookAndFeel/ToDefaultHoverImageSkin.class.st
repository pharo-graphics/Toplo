Class {
	#name : #ToDefaultHoverImageSkin,
	#superclass : #ToDefaultImageSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Image'
}

{ #category : #testing }
ToDefaultHoverImageSkin class >> type [

	^ #defaultHover
]

{ #category : #built }
ToDefaultHoverImageSkin >> builtForegroundHover [

	^ self theme colorPrimary
]
