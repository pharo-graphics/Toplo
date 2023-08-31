Class {
	#name : #ToButtonLabelSkin,
	#superclass : #ToLabelSkin,
	#category : #'Toplo-Widget-Album-Skin-Label'
}

{ #category : #accessing }
ToButtonLabelSkin >> labelLookIn: anElement [

	^ (self type buttonLabelLookIn: anElement)
		  weight: anElement toTheme fontWeightStrong;
		  defaultFontName: anElement toTheme fontFamilyCode;
		  yourself
]
