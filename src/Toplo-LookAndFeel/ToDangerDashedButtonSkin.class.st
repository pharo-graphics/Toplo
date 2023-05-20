Class {
	#name : #ToDangerDashedButtonSkin,
	#superclass : #ToDashedButtonSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Button'
}

{ #category : #testing }
ToDangerDashedButtonSkin class >> type [

	^ #dangerDashed
]

{ #category : #built }
ToDangerDashedButtonSkin >> builtBorderBuilder [

	| builder |
	builder := super builtBorderBuilder.
	builder paint: self theme colorError.
	^ builder
]

{ #category : #built }
ToDangerDashedButtonSkin >> builtBorderHoverBuilder [

	| builder |
	builder := super builtBorderHoverBuilder.
	builder paint: self theme colorErrorHover.
	^ builder
]

{ #category : #built }
ToDangerDashedButtonSkin >> imageSkinType [

	^ ToDangerHoverImageSkin type
]

{ #category : #built }
ToDangerDashedButtonSkin >> labelSkinType [

	^ ToDangerHoverLabelSkin type
]
