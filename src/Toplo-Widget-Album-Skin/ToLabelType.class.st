Class {
	#name : #ToLabelType,
	#superclass : #Object,
	#category : #'Toplo-Widget-Album-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToLabelType >> buttonLabelLookIn: anElement [

	| prop attrBuilder |
	prop := ToPseudoProperty new name: #'text-attributes'.
	prop writer: [ :e :v |
		e text attributes: v attributes.
		e textChanged ].
	attrBuilder := BlTextAttributesBuilder new
		               weight: anElement toTheme fontWeightStrong;
		               defaultFontName: anElement toTheme fontFamilyCode;
		               defaultFontSize: anElement toTheme fontSize;
		               lineSpacing: anElement toTheme lineHeight;
		               yourself.
	^ (ToLookUpdater new property: prop)
		  when: ToDisabledLookEvent value: (attrBuilder
				   foreground: anElement toTheme colorTextDisabled;
				   yourself);
		  when: ToInitialLookEvent value: (attrBuilder
			   foreground: anElement toTheme colorText;
			   yourself);
		  when: ToHoveredLookEvent value: (attrBuilder
			   foreground: anElement toTheme colorPrimary;
			   yourself);
		  when: ToPressedLookEvent value: (attrBuilder
			   foreground: anElement toTheme colorPrimaryPressed;
			   yourself);
		  yourself
]

{ #category : #accessing }
ToLabelType >> textColorIn: anElement [

	^ self subclassResponsibility 
]
