Class {
	#name : #ToLabelPrimaryType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Album-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToLabelPrimaryType >> buttonLabelLookIn: anElement [

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
			   foreground: anElement toTheme colorTextLightSolid;
			   yourself);
		  yourself
]

{ #category : #accessing }
ToLabelPrimaryType >> textColorIn: anElement [

	^  anElement toTheme colorTextLightSolid
]
