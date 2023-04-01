Class {
	#name : #ToPrimaryLabelSkin,
	#superclass : #ToAbstractLabelSkin,
	#category : #'Toplo-LookAndFeel-ToTheme-Skins - Label'
}

{ #category : #accessing }
ToPrimaryLabelSkin class >> type [

	^ #primary
]

{ #category : #built }
ToPrimaryLabelSkin >> builtForeground [

	^ self theme colorTextLightSolid
]
