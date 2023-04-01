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
ToPrimaryButtonSkin >> labelSkinType [

	^ ToPrimaryLabelSkin type
]
