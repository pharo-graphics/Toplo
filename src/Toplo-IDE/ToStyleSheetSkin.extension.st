Extension { #name : #ToStyleSheetSkin }

{ #category : #'*Toplo-IDE' }
ToStyleSheetSkin >> inspectorDisplayColor [

	^ Smalltalk ui theme listTextColor
]

{ #category : #'*Toplo-IDE' }
ToStyleSheetSkin >> styleSheetRulesCount [

	^ self skinEventListeners size.
]
