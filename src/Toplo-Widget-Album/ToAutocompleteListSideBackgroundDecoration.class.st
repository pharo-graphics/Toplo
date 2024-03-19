Class {
	#name : #ToAutocompleteListSideBackgroundDecoration,
	#superclass : #BlSideBackgroundDecoration,
	#category : #'Toplo-Widget-Album-Autocompletion'
}

{ #category : #accessing }
ToAutocompleteListSideBackgroundDecoration >> aeBackgroundBoundsOn: aeCanvas in: anInfiniteElement [


	| cairoScaledFont fontExtents cairoGlyphsArray rect |
	cairoScaledFont := self aeCairoScaledFontOn: aeCanvas in: anInfiniteElement.
	fontExtents := cairoScaledFont fontExtents.
	cairoGlyphsArray := cairoScaledFont glyphArrayForString:
		                    anInfiniteElement listElement currentPattern.
	rect := anInfiniteElement bounds asRectangle.
	aeCanvas
		textExtentsFor: cairoGlyphsArray
		scaledFont: cairoScaledFont
		do: [ :aTextExtents | ^ rect withWidth: aTextExtents width ]
]

{ #category : #accessing }
ToAutocompleteListSideBackgroundDecoration >> aeCairoScaledFontOn: aeCanvas in: anInfiniteElement [

	| fontAndStyleBuilder freeTypeFont |
	fontAndStyleBuilder := BlTextFontAndStyleBuilder new.
	fontAndStyleBuilder familyName: anInfiniteElement listElement fontName.
	freeTypeFont := fontAndStyleBuilder font asAeFTFace.
	^ aeCanvas scaledFontForFace: freeTypeFont size: anInfiniteElement listElement fontSize
]

{ #category : #initialization }
ToAutocompleteListSideBackgroundDecoration >> defaultBackground [

	^ (Color veryLightGray alpha: 0.2) asBlBackground
]
