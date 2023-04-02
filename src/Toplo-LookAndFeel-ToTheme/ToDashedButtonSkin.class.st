"
Dashed button: used for adding action commonly.
"
Class {
	#name : #ToDashedButtonSkin,
	#superclass : #ToAbstractButtonSkin,
	#category : #'Toplo-LookAndFeel-ToTheme-Skins - Buttons'
}

{ #category : #testing }
ToDashedButtonSkin class >> type [

	^ #dashed
]

{ #category : #built }
ToDashedButtonSkin >> builtBackground [

	^ self theme colorBgContainer
]

{ #category : #built }
ToDashedButtonSkin >> builtBackgroundHover [ 

	^ self theme colorBgContainer
]

{ #category : #built }
ToDashedButtonSkin >> builtBorderBuilder [

	| builder |
	builder := super builtBorderBuilder.
	builder dashArray: self theme dashed.
	^ builder
]

{ #category : #built }
ToDashedButtonSkin >> builtBorderHoverBuilder [

	| builder |
	builder := super builtBorderHoverBuilder.
	builder paint: self theme colorPrimaryHover.
	builder dashArray: self theme dashed.
	^ builder
]

{ #category : #built }
ToDashedButtonSkin >> builtDefaultSize [

	^ 0 @ (self theme controlHeight)
]

{ #category : #built }
ToDashedButtonSkin >> builtPadding [ 

	^ BlInsets top: (self theme paddingXS / 2) left: (self theme paddingContentHorizontal) bottom: (self theme paddingXS / 2) right: (self theme paddingContentHorizontal)
]

{ #category : #built }
ToDashedButtonSkin >> builtShadow [

	^ BlGaussianShadowEffect
		  color: (self theme colorBorder alphaMixed: 0.233 with: self theme backgroundColor)
		  width: 2
		  offset: 0 @ 2
]
