Class {
	#name : #ToButtonLabelSkin,
	#superclass : #ToBasicLabelSkin,
	#instVars : [
		'buttonType'
	],
	#category : #'Toplo-Widget-Label-Skins'
}

{ #category : #accessing }
ToButtonLabelSkin >> buttonType [

	^ buttonType
]

{ #category : #accessing }
ToButtonLabelSkin >> buttonType: aButtonType [

	buttonType := aButtonType
]

{ #category : #accessing }
ToButtonLabelSkin >> labelLookIn: anElement [

	^ (self buttonType labelLookIn: anElement)
		  weight: anElement toTheme fontWeightStrong;
		  defaultFontName: anElement toTheme fontFamilyCode;
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToButtonLabelSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	self addLook: (self labelLookIn: anElement)
]
