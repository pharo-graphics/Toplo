Class {
	#name : #ToH1LabelSkin,
	#superclass : #ToThemeLabelSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Label'
}

{ #category : #accessing }
ToH1LabelSkin class >> type [

	^ #h1
]

{ #category : #built }
ToH1LabelSkin >> builtForeground [

	^ self theme colorTextHeading
]

{ #category : #built }
ToH1LabelSkin >> builtTextAttributes [

	| ropedText |
	ropedText := '' asRopedText.
	ropedText lineSpacing: self theme lineHeightHeading1.
	ropedText defaultFontSize: self theme fontSizeHeading1.
	ropedText defaultFontName: self theme fontFamilyCode.
	ropedText weight: self theme fontWeightStrong.

	^ ropedText rope attributes
]
