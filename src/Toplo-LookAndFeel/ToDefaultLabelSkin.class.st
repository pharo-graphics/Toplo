Class {
	#name : #ToDefaultLabelSkin,
	#superclass : #ToAbstractLabelSkin,
	#category : #'Toplo-LookAndFeel-Skins - Labels'
}

{ #category : #built }
ToDefaultLabelSkin >> builtBackground [

	^ self theme colorText
]
