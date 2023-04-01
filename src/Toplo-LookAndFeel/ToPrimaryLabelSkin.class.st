Class {
	#name : #ToPrimaryLabelSkin,
	#superclass : #ToAbstractLabelSkin,
	#category : #'Toplo-LookAndFeel-Skins - Labels'
}

{ #category : #accessing }
ToPrimaryLabelSkin class >> type [

	^ #primary
]

{ #category : #built }
ToPrimaryLabelSkin >> builtBackground [

	^ self theme colorText
]
