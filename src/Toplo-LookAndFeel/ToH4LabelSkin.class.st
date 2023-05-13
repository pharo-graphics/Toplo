Class {
	#name : #ToH4LabelSkin,
	#superclass : #ToAbstractLabelSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Label'
}

{ #category : #accessing }
ToH4LabelSkin class >> type [

	^ #h4
]

{ #category : #built }
ToH4LabelSkin >> builtForeground [

	^ self theme colorTextHeading
]

{ #category : #built }
ToH4LabelSkin >> builtTextAttributes [

	| ropedText |
	ropedText := '' asRopedText.
	ropedText lineSpacing: self theme lineHeightHeading4.
	ropedText defaultFontSize: self theme fontSizeHeading4.
	ropedText defaultFontName: self theme fontFamilyCode.
	ropedText weight: self theme fontWeightStrong.

	^ ropedText rope attributes
]
