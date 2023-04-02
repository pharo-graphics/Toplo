Class {
	#name : #ToH5LabelSkin,
	#superclass : #ToAbstractLabelSkin,
	#category : #'Toplo-LookAndFeel-ToTheme-Skins - Label'
}

{ #category : #accessing }
ToH5LabelSkin class >> type [

	^ #h5
]

{ #category : #built }
ToH5LabelSkin >> builtForeground [

	^ self theme colorText
]

{ #category : #built }
ToH5LabelSkin >> builtTextAttributes [

	| ropedText |
	ropedText := '' asRopedText.
	ropedText lineSpacing: self theme lineHeightHeading5.
	ropedText defaultFontSize: self theme fontSizeHeading5.
	ropedText defaultFontName: self theme fontFamilyCode.
	ropedText weight: self theme fontWeightStrong.

	^ ropedText rope attributes
]
