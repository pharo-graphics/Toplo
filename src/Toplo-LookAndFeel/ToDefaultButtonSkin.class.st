"
Default button: indicate a series of actions without priority.
"
Class {
	#name : #ToDefaultButtonSkin,
	#superclass : #ToThemeButtonSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Button'
}

{ #category : #built }
ToDefaultButtonSkin >> builtBackground [

	^ self theme colorBgContainer 
]

{ #category : #built }
ToDefaultButtonSkin >> builtBackgroundHover [ 

	^ self theme colorBgContainer
]

{ #category : #built }
ToDefaultButtonSkin >> builtBackgroundPressed [ 

	^ self theme colorBgContainer
]

{ #category : #built }
ToDefaultButtonSkin >> builtBorderHoverBuilder [

	| builder |
	builder := super builtBorderHoverBuilder.
	builder paint: self theme colorPrimaryHover.
	^ builder
]

{ #category : #built }
ToDefaultButtonSkin >> builtBorderPressedBuilder [

	| builder |
	builder := super builtBorderPressedBuilder.
	builder paint: self theme colorPrimaryPressed.
	^ builder
]

{ #category : #built }
ToDefaultButtonSkin >> builtDefaultSize [

	^ 0 @ (self theme controlHeight)
]

{ #category : #built }
ToDefaultButtonSkin >> builtGeometry [

	^ BlRoundedRectangleGeometry cornerRadius: self theme borderRadius
]

{ #category : #built }
ToDefaultButtonSkin >> builtPadding [ 

	^ BlInsets top: (self theme paddingXS / 2) left: (self theme paddingContentHorizontal) bottom: (self theme paddingXS / 2) right: (self theme paddingContentHorizontal)
]

{ #category : #built }
ToDefaultButtonSkin >> builtShadow [

	^ BlGaussianShadowEffect
		  color: (self theme colorBorder alphaMixed: 0.233 with: self theme backgroundColor)
		  width: 2
		  offset: 0 @ 2
]

{ #category : #built }
ToDefaultButtonSkin >> imageSkinType [

	^ ToDefaultHoverImageSkin type
]

{ #category : #built }
ToDefaultButtonSkin >> labelSkinType [

	^ ToDefaultButtonLabelSkin type
]
