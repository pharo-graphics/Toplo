Class {
	#name : #ToDefaultHoverLabelSkin,
	#superclass : #ToDefaultLabelSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Label'
}

{ #category : #testing }
ToDefaultHoverLabelSkin class >> type [

	^ #defaultHover
]

{ #category : #built }
ToDefaultHoverLabelSkin >> builtForegroundHover [

	^ self theme colorPrimary
]
