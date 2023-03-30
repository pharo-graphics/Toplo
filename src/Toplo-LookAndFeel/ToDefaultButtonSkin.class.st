Class {
	#name : #ToDefaultButtonSkin,
	#superclass : #ToAbstractButtonSkin,
	#category : #'Toplo-LookAndFeel-Skins'
}

{ #category : #built }
ToDefaultButtonSkin >> builtBackground [

	^ self theme colorBgContainer 
]
