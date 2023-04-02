Class {
	#name : #ToH3LabelSkin,
	#superclass : #ToAbstractLabelSkin,
	#category : #'Toplo-LookAndFeel-ToTheme-Skins - Label'
}

{ #category : #accessing }
ToH3LabelSkin class >> type [

	^ #h3
]

{ #category : #built }
ToH3LabelSkin >> builtForeground [

	^ self theme colorTextHeading
]

{ #category : #built }
ToH3LabelSkin >> builtTextAttributes [

	| ropedText |
	ropedText := '' asRopedText.
	ropedText lineSpacing: self theme lineHeightHeading3.
	ropedText defaultFontSize: self theme fontSizeHeading3.
	ropedText defaultFontName: self theme fontFamilyCode.
	ropedText weight: self theme fontWeightStrong.

	^ ropedText rope attributes
]
