Class {
	#name : #ToLabelDangerType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Album-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToLabelDangerType >> buttonLabelLookIn: anElement [

	^ (super buttonLabelLookIn: anElement)
		  when: ToInitialLookEvent value: (BlTextAttributesBuilder new
			   foreground: anElement toTheme colorError;
			   yourself);
		  when: ToHoveredLookEvent value: (BlTextAttributesBuilder new
			   foreground: anElement toTheme colorErrorHover;
			   yourself);
		  when: ToPressedLookEvent value: (BlTextAttributesBuilder new
			   foreground: anElement toTheme colorError darker;
			   yourself);
		  yourself
]

{ #category : #accessing }
ToLabelDangerType >> textColorIn: anElement [

	^ anElement toTheme colorError
]
