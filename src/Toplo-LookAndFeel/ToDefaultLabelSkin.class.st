Class {
	#name : #ToDefaultLabelSkin,
	#superclass : #ToAbstractLabelSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Label'
}

{ #category : #built }
ToDefaultLabelSkin >> builtForeground [

	^ self theme colorText
]

{ #category : #built }
ToDefaultLabelSkin >> builtTextAttributes [

	| ropedText |
	ropedText := '' asRopedText.
	ropedText lineSpacing: self theme lineHeight.
	ropedText defaultFontSize: self theme fontSize.
	ropedText defaultFontName: self theme fontFamilyCode.
	ropedText weight: self theme fontWeightStrong.

	^ ropedText rope attributes
]
