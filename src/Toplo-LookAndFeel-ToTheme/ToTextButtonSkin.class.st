"
Text button: used for the most secondary action.
"
Class {
	#name : #ToTextButtonSkin,
	#superclass : #ToAbstractButtonSkin,
	#category : #'Toplo-LookAndFeel-ToTheme-Skins - Buttons'
}

{ #category : #accessing }
ToTextButtonSkin class >> type [

	^ #text
]

{ #category : #built }
ToTextButtonSkin >> builtBackground [

	^ self theme colorBgContainer
]

{ #category : #built }
ToTextButtonSkin >> builtBorder [

	^ nil
]
