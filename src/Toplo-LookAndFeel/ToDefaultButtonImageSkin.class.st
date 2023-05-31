Class {
	#name : #ToDefaultButtonImageSkin,
	#superclass : #ToDefaultImageSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Image'
}

{ #category : #testing }
ToDefaultButtonImageSkin class >> type [

	^ #defaultHover
]

{ #category : #built }
ToDefaultButtonImageSkin >> builtForegroundHover [

	^ self theme colorPrimary
]

{ #category : #built }
ToDefaultButtonImageSkin >> builtForegroundPressed [

	^ self theme colorPrimaryPressed
]
