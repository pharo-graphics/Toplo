Class {
	#name : #ToDangerLabelSkin,
	#superclass : #ToAbstractLabelSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Label'
}

{ #category : #accessing }
ToDangerLabelSkin class >> type [

	^ #danger
]

{ #category : #built }
ToDangerLabelSkin >> builtForeground [

	^ self theme colorError
]

{ #category : #built }
ToDangerLabelSkin >> builtTextAttributes [

	| ropedText |
	ropedText := '' asRopedText.
	ropedText lineSpacing: self theme lineHeight.
	ropedText defaultFontSize: self theme fontSize.
	ropedText defaultFontName: self theme fontFamilyCode.
	ropedText weight: self theme fontWeightStrong.

	^ ropedText rope attributes
]
