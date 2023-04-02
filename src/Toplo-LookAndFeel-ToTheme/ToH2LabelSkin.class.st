Class {
	#name : #ToH2LabelSkin,
	#superclass : #ToAbstractLabelSkin,
	#category : #'Toplo-LookAndFeel-ToTheme-Skins - Label'
}

{ #category : #accessing }
ToH2LabelSkin class >> type [

	^ #h2
]

{ #category : #built }
ToH2LabelSkin >> builtForeground [

	^ self theme colorText
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
