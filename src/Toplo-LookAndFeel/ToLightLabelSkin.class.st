Class {
	#name : #ToLightLabelSkin,
	#superclass : #ToAbstractLabelSkin,
	#category : #'Toplo-LookAndFeel-Skins - Labels'
}

{ #category : #built }
ToLightLabelSkin >> builtBackground [

	^ self theme colorText
]
