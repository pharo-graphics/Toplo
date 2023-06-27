Class {
	#name : #ToH2LabelSkin,
	#superclass : #ToThemeLabelSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Label'
}

{ #category : #accessing }
ToH2LabelSkin class >> type [

	^ #h2
]

{ #category : #built }
ToH2LabelSkin >> builtForeground [

	^ self theme colorTextHeading
]

{ #category : #built }
ToH2LabelSkin >> builtTextAttributes [

	| ropedText |
	ropedText := '' asRopedText.
	ropedText lineSpacing: self theme lineHeightHeading2.
	ropedText defaultFontSize: self theme fontSizeHeading2.
	ropedText defaultFontName: self theme fontFamilyCode.
	ropedText weight: self theme fontWeightStrong.

	^ ropedText rope attributes
]
