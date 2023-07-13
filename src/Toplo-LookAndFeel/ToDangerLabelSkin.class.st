Class {
	#name : #ToDangerLabelSkin,
	#superclass : #ToThemeLabelSkin,
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

	| builder |
	builder  := BlTextAttributesBuilder new..
	builder lineSpacing: self theme lineHeight.
	builder defaultFontSize: self theme fontSize.
	builder defaultFontName: self theme fontFamilyCode.
	builder weight: self theme fontWeightStrong.

	^ builder attributes
]
