"
Text button: used for the most secondary action.
"
Class {
	#name : #ToTextButtonSkin,
	#superclass : #ToThemeButtonSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Button'
}

{ #category : #accessing }
ToTextButtonSkin class >> type [

	^ #text
]

{ #category : #built }
ToTextButtonSkin >> builtBackground [

	^ Color transparent
]

{ #category : #built }
ToTextButtonSkin >> builtBackgroundHover [ 

	^ self theme colorBgTextHover
]

{ #category : #built }
ToTextButtonSkin >> builtBackgroundPressed [ 

	^ self theme colorBgTextActive
]

{ #category : #built }
ToTextButtonSkin >> builtBorder [

	^ nil
]

{ #category : #built }
ToTextButtonSkin >> builtBorderHover [

	^ nil
]

{ #category : #built }
ToTextButtonSkin >> builtBorderPressed [

	^ nil
]

{ #category : #built }
ToTextButtonSkin >> builtDefaultSize [

	^ 0 @ (self theme controlHeight)
]

{ #category : #built }
ToTextButtonSkin >> builtGeometry [

	^ BlRoundedRectangleGeometry cornerRadius: self theme borderRadius
]

{ #category : #built }
ToTextButtonSkin >> builtPadding [ 

	^ BlInsets top: (self theme paddingXS / 2) left: (self theme paddingContentHorizontal) bottom: (self theme paddingXS / 2) right: (self theme paddingContentHorizontal)
]

{ #category : #built }
ToTextButtonSkin >> builtShadow [

	^ nil
]

{ #category : #built }
ToTextButtonSkin >> imageSkinType [

	^ ToDefaultImageSkin type
]
