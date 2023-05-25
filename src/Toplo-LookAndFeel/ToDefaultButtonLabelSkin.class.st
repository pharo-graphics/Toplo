Class {
	#name : #ToDefaultButtonLabelSkin,
	#superclass : #ToDefaultLabelSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Label'
}

{ #category : #testing }
ToDefaultButtonLabelSkin class >> type [

	^ #defaultHover
]

{ #category : #built }
ToDefaultButtonLabelSkin >> builtForegroundHover [

	^ self theme colorPrimary
]

{ #category : #built }
ToDefaultButtonLabelSkin >> builtForegroundPressed [

	^ self theme colorPrimaryPressed
]
