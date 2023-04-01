Class {
	#name : #ToLinkLabelSkin,
	#superclass : #ToAbstractLabelSkin,
	#category : #'Toplo-LookAndFeel-ToTheme-Skins - Label'
}

{ #category : #accessing }
ToLinkLabelSkin class >> type [

	^ #link
]

{ #category : #built }
ToLinkLabelSkin >> builtBackground [

	^ self theme colorLink
]
