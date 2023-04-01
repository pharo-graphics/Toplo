"
Default button: indicate a series of actions without priority.
"
Class {
	#name : #ToDefaultButtonSkin,
	#superclass : #ToAbstractButtonSkin,
	#category : #'Toplo-LookAndFeel-ToTheme-Skins - Buttons'
}

{ #category : #built }
ToDefaultButtonSkin >> builtBackground [

	^ self theme colorBgContainer 
]

{ #category : #built }
ToDefaultButtonSkin >> builtDefaultSize [

	^ 0 @ (self theme controlHeight)
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
