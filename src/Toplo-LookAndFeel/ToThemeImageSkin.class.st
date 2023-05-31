Class {
	#name : #ToThemeImageSkin,
	#superclass : #ToAbstractImageSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Image'
}

{ #category : #testing }
ToThemeImageSkin class >> isAbstract [

	^ self == ToThemeImageSkin
]

{ #category : #built }
ToThemeImageSkin >> builtForeground [

	^ self theme colorText
]
