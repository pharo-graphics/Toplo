Class {
	#name : #ToLabelLinkType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Album-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToLabelLinkType >> buttonLabelLookIn: anElement [

	^ (super buttonLabelLookIn: anElement)
		  when: ToInitialLookEvent value: (BlTextAttributesBuilder new
			   foreground: anElement toTheme colorLink;
			   yourself);
		  when: ToHoveredLookEvent value: (BlTextAttributesBuilder new
			   foreground: anElement toTheme colorLinkHover;
			   yourself);
		  when: ToPressedLookEvent value: (BlTextAttributesBuilder new
			   foreground: anElement toTheme colorPrimaryPressed;
			   yourself);
		  yourself
]

{ #category : #accessing }
ToLabelLinkType >> textColorIn: anElement [

	^ anElement toTheme colorLink
]
