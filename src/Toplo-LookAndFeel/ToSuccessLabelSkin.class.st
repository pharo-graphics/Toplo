Class {
	#name : #ToSuccessLabelSkin,
	#superclass : #ToThemeLabelSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Label'
}

{ #category : #accessing }
ToSuccessLabelSkin class >> type [

	^ #success
]

{ #category : #built }
ToSuccessLabelSkin >> builtForeground [

	^ self theme colorSuccess
]

{ #category : #built }
ToSuccessLabelSkin >> builtTextAttributes [

	| ropedText |
	ropedText := '' asRopedText.
	ropedText lineSpacing: self theme lineHeight.
	ropedText defaultFontSize: self theme fontSize.
	ropedText defaultFontName: self theme fontFamilyCode.
	ropedText weight: self theme fontWeightStrong.

	^ ropedText rope attributes
]
