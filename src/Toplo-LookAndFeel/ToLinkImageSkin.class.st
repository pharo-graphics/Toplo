Class {
	#name : #ToLinkImageSkin,
	#superclass : #ToThemeImageSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Image'
}

{ #category : #testing }
ToLinkImageSkin class >> type [

	^ #link
]

{ #category : #built }
ToLinkImageSkin >> builtForeground [

	^ self theme colorLink
]

{ #category : #built }
ToLinkImageSkin >> builtForegroundHover [

	^ self theme colorLinkHover
]
