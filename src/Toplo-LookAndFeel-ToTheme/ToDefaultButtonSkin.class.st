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
