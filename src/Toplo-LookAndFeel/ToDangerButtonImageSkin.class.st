Class {
	#name : #ToDangerButtonImageSkin,
	#superclass : #ToDefaultButtonImageSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Image'
}

{ #category : #testing }
ToDangerButtonImageSkin class >> type [

	^ #dangerHover
]

{ #category : #built }
ToDangerButtonImageSkin >> builtForeground [

	^ self theme colorError
]

{ #category : #built }
ToDangerButtonImageSkin >> builtForegroundHover [

	^ self theme colorErrorHover
]

{ #category : #built }
ToDangerButtonImageSkin >> builtForegroundPressed [

	^ self theme colorError darker
]
