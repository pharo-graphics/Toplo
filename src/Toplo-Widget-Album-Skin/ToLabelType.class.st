Class {
	#name : #ToLabelType,
	#superclass : #Object,
	#category : #'Toplo-Widget-Album-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToLabelType >> buttonLabelLookIn: anElement [

	^ (anElement toTheme styleSheet newLookUpdaterForPropertyName: #'text-attributes-with-builder')
		  when: ToDisabledLookEvent value: (BlTextAttributesBuilder new
				   foreground: anElement toTheme colorTextDisabled;
				   yourself);
		  when: ToInstallLookEvent value: (BlTextAttributesBuilder new
					weight: anElement toTheme fontWeightStrong;
		         defaultFontName: anElement toTheme fontFamilyCode;
		         defaultFontSize: anElement toTheme fontSize;
		         lineSpacing: anElement toTheme lineHeight;
			   yourself);
		  when: ToInitialLookEvent value: (BlTextAttributesBuilder new
			   foreground: anElement toTheme colorText;
			   yourself);
		  when: ToHoveredLookEvent value: (BlTextAttributesBuilder new
			   foreground: anElement toTheme colorPrimary;
			   yourself);
		  when: ToPressedLookEvent value: (BlTextAttributesBuilder new
			   foreground: anElement toTheme colorPrimaryPressed;
			   yourself);
		  yourself
]

{ #category : #accessing }
ToLabelType >> textColorIn: anElement [

	^ self subclassResponsibility 
]
