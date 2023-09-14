Class {
	#name : #ToLabelPrimaryType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Album-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToLabelPrimaryType >> buttonLabelLookIn: anElement [

	^ (super buttonLabelLookIn: anElement)
			whenAll: { ToInitialLookEvent. ToHoveredLookEvent. ToPressedLookEvent } 
			value: (BlTextAttributesBuilder new
				foreground: anElement toTheme colorTextLightSolid;
			 	yourself);
		  yourself
]

{ #category : #accessing }
ToLabelPrimaryType >> textColorIn: anElement [

	^  anElement toTheme colorTextLightSolid
]
