Class {
	#name : #ToLinkLabelSkin,
	#superclass : #ToAbstractLabelSkin,
	#category : #'Toplo-LookAndFeel-Skins - Labels'
}

{ #category : #built }
ToLinkLabelSkin >> builtBackground [

	^ self theme colorLink
]
