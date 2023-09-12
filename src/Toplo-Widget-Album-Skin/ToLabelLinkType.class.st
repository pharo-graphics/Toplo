Class {
	#name : #ToLabelLinkType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Album-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToLabelLinkType >> buttonLabelLookIn: anElement [

	| prop attrBuilder |
	prop := ToExplicitPropertyDef new name: #'text-attributes'.
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
			   foreground: anElement toTheme colorLink;
			   yourself);
		  when: ToHoveredLookEvent value: (attrBuilder
			   foreground: anElement toTheme colorLinkHover;
			   yourself);
		  when: ToPressedLookEvent value: (attrBuilder
			   foreground: anElement toTheme colorPrimaryPressed;
			   yourself);
		  yourself
]

{ #category : #accessing }
ToLabelLinkType >> textColorIn: anElement [

	^ anElement toTheme colorLink
]
