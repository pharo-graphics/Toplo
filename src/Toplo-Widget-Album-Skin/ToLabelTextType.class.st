Class {
	#name : #ToLabelTextType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Album-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToLabelTextType >> buttonLabelLookIn: anElement [

	^ (super buttonLabelLookIn: anElement)
			whenAll: { ToInitialLookEvent. ToHoveredLookEvent. ToPressedLookEvent } 
			value: (BlTextAttributesBuilder new
				   		foreground: anElement toTheme colorText;
				   		yourself);
		  yourself
]

{ #category : #accessing }
ToLabelTextType >> textColorIn: anElement [

	^ anElement toTheme colorText
]
