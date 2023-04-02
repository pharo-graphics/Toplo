Class {
	#name : #ToWarningLabelSkin,
	#superclass : #ToAbstractLabelSkin,
	#category : #'Toplo-LookAndFeel-ToTheme-Skins - Label'
}

{ #category : #accessing }
ToWarningLabelSkin class >> type [

	^ #warning
]

{ #category : #built }
ToWarningLabelSkin >> builtForeground [

	^ self theme colorWarning
]

{ #category : #built }
ToWarningLabelSkin >> builtTextAttributes [

	| ropedText |
	ropedText := '' asRopedText.
	ropedText lineSpacing: self theme lineHeight.
	ropedText defaultFontSize: self theme fontSize.
	ropedText defaultFontName: self theme fontFamilyCode.
	ropedText weight: self theme fontWeightStrong.

	^ ropedText rope attributes
]
