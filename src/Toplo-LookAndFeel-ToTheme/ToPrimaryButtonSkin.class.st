"
Primary button: indicate the main action, one primary button at most in one section.
"
Class {
	#name : #ToPrimaryButtonSkin,
	#superclass : #ToAbstractButtonSkin,
	#category : #'Toplo-LookAndFeel-ToTheme-Skins - Buttons'
}

{ #category : #accessing }
ToPrimaryButtonSkin class >> type [

	^ #primary
]

{ #category : #built }
ToPrimaryButtonSkin >> builtBackground [

	^ self theme colorPrimary 
]

{ #category : #built }
ToPrimaryButtonSkin >> builtBorder [

	^ nil
]

{ #category : #built }
ToPrimaryButtonSkin >> builtDefaultSize [

	^ 0 @ (self theme controlHeight)
]

{ #category : #built }
ToPrimaryButtonSkin >> builtPadding [ 

	^ BlInsets top: (self theme paddingXS / 2) left: (self theme paddingContentHorizontal) bottom: (self theme paddingXS / 2) right: (self theme paddingContentHorizontal)
]

{ #category : #built }
ToPrimaryButtonSkin >> builtShadow [

	^ BlGaussianShadowEffect
		  color: (self theme colorPrimary alphaMixed: 0.233 with: self theme backgroundColor)
		  width: 2
		  offset: 0 @ 2
]

{ #category : #built }
ToPrimaryButtonSkin >> labelSkinType [

	^ ToPrimaryLabelSkin type
]
