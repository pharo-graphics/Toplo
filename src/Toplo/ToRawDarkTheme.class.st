Class {
	#name : #ToRawDarkTheme,
	#superclass : #ToRawTheme,
	#category : #'Toplo-Core-Theme'
}

{ #category : #accessing }
ToRawDarkTheme class >> defaultTokenProperties [

	^ super defaultTokenProperties , {
		  (ToTokenProperty
			   name: #'sh-style-table'
			   value: SHRBTextStyler darkStyleTable).
		  (ToTokenProperty
			   name: #'background-color'
			   value: (Color fromHexString: '#313339')).
		  (ToTokenProperty
			   name: #'color-bg-container'
			   value: (Color fromHexString: '#313339')).
		  (ToTokenProperty name: #'color-bg-tooltip' value: Color black).
		  (ToTokenProperty
			   name: #'color-primary-unchecked'
			   value: (Color fromHexString: '#313339')).

		  (ToTokenProperty
			   name: #'color-primary-selection-focused'
			   value: (self defaultColorPrimary alpha: 0.8)).
		  (ToTokenProperty
			   name: #'color-primary-selection-unfocused'
			   value: (self defaultColorPrimary alpha: 0.2)).

		  (ToTokenProperty
			   name: #'color-bg-container-disabled'
			   value: (Color white alpha: 0.15)).
		  (ToTokenProperty
			   name: #'color-bg-text-active'
			   value: (Color black alpha: 0.15)).
		  (ToTokenProperty
			   name: #'color-bg-text-hover'
			   value: (Color white alpha: 0.30)).
		  (ToTokenProperty
			   name: #'color-border'
			   value: (Color fromHexString: '#a6a6a6')).
		  (ToTokenProperty name: #'color-border-disabled' value: (Color
				    r: 0.7
				    g: 0.7
				    b: 0.7
				    alpha: 0.5)).
		  (ToTokenProperty
			   name: #'color-error-bg'
			   value: (Color fromHexString: '#2a1215')).
		  (ToTokenProperty name: #'color-image-disabled' value: (Color
				    r: 0.7
				    g: 0.7
				    b: 0.7
				    alpha: 1.0)).
		  (ToTokenProperty
			   name: #'color-text'
			   value: (Color r: 255 g: 255 b: 255)).
		  (ToTokenProperty name: #'color-text-disabled' value: (Color
				    r: 0.7
				    g: 0.7
				    b: 0.7
				    alpha: 0.5)).
		  (ToTokenProperty name: #'color-text-heading' value: (Color
				    r: 255
				    g: 255
				    b: 255
				    alpha: 0.88)).
		  (ToTokenProperty
			   name: #'color-text-secondary'
			   value: (Color white alpha: 0.45)).
		  (ToTokenProperty
			   name: #'text-foreground-in-tooltip'
			   value: Color white) }
]

{ #category : #accessing }
ToRawDarkTheme class >> label [

	^'Raw Dark'
]
