Class {
	#name : #ToDefaultLabelSkin,
	#superclass : #ToAbstractLabelSkin,
	#category : #'Toplo-LookAndFeel-ToTheme-Skins - Label'
}

{ #category : #built }
ToDefaultLabelSkin >> builtBackground [

	^ self theme colorText
]
