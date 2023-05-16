Class {
	#name : #ToDangerButtonSkin,
	#superclass : #ToDefaultButtonSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Button'
}

{ #category : #testing }
ToDangerButtonSkin class >> type [

	^ #danger
]

{ #category : #built }
ToDangerButtonSkin >> builtBorderBuilder [

	| builder |
	builder := super builtBorderBuilder.
	builder paint: self theme colorError.
	^ builder
]

{ #category : #built }
ToDangerButtonSkin >> builtBorderHoverBuilder [

	| builder |
	builder := super builtBorderBuilder.
	builder paint: self theme colorErrorHover.
	^ builder
]

{ #category : #built }
ToDangerButtonSkin >> labelSkinType [

	^ ToDangerHoverLabelSkin type
]
