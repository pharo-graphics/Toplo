Class {
	#name : #ToDangerHoverImageSkin,
	#superclass : #ToDefaultHoverImageSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Image'
}

{ #category : #testing }
ToDangerHoverImageSkin class >> type [

	^ #dangerHover
]

{ #category : #built }
ToDangerHoverImageSkin >> builtForeground [

	^ self theme colorError
]

{ #category : #built }
ToDangerHoverImageSkin >> builtForegroundHover [

	^ self theme colorErrorHover
]
