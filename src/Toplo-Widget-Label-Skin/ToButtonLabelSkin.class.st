Class {
	#name : #ToButtonLabelSkin,
	#superclass : #ToLabelSkin,
	#category : #'Toplo-Widget-Label-Skin'
}

{ #category : #accessing }
ToButtonLabelSkin >> labelLookIn: anElement [

	^ (self type buttonLabelLookIn: anElement)
		  weight: anElement toTheme fontWeightStrong;
		  defaultFontName: anElement toTheme fontFamilyCode;
		  yourself
]
