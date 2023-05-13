Class {
	#name : #ToButtonTestSkin,
	#superclass : #ToAbstractButtonSkin,
	#category : #'Toplo-LookAndFeel-ToTheme-Tests-Skins - Buttons'
}

{ #category : #testing }
ToButtonTestSkin class >> type [

	^ #default
]

{ #category : #built }
ToButtonTestSkin >> builtBackground [ 

	^ nil
]

{ #category : #built }
ToButtonTestSkin >> builtBackgroundHover [ 

	^ nil
]

{ #category : #built }
ToButtonTestSkin >> builtPadding [ 

	^ self theme customPadding
]

{ #category : #built }
ToButtonTestSkin >> builtShadow [

	^ nil
]
