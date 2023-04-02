Class {
	#name : #ToSecondaryLabelSkin,
	#superclass : #ToAbstractLabelSkin,
	#category : #'Toplo-LookAndFeel-ToTheme-Skins - Label'
}

{ #category : #accessing }
ToSecondaryLabelSkin class >> type [

	^ #secondary
]

{ #category : #built }
ToSecondaryLabelSkin >> builtForeground [

	^ self theme colorTextSecondary
]

{ #category : #built }
ToSecondaryLabelSkin >> builtTextAttributes [

	| ropedText |
	ropedText := '' asRopedText.
	ropedText lineSpacing: self theme lineHeight.
	ropedText defaultFontSize: self theme fontSize.
	ropedText defaultFontName: self theme fontFamilyCode.
	ropedText weight: self theme fontWeightStrong.

	^ ropedText rope attributes
]
