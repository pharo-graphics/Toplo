Class {
	#name : #ToPrimaryButtonSkin,
	#superclass : #ToAbstractButtonSkin,
	#category : #'Toplo-LookAndFeel-Skins'
}

{ #category : #built }
ToPrimaryButtonSkin >> builtBackground [

	^ self theme colorPrimary 
]
