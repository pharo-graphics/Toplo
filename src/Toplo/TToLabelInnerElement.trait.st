Trait {
	#name : #TToLabelInnerElement,
	#category : #'Toplo-Widget-Labels'
}

{ #category : #'api - editor' }
TToLabelInnerElement >> editorShortcutsIn: aLabel [

	^ self explicitRequirement 
]

{ #category : #'api - editor' }
TToLabelInnerElement >> newEditorIn: aLabel [

	^ self explicitRequirement 
]

{ #category : #'api - overlay' }
TToLabelInnerElement >> overlayReferentElement [

	^ self
]

{ #category : #'api - text accessing' }
TToLabelInnerElement >> text [

	^ self explicitRequirement 
]

{ #category : #'api - text accessing' }
TToLabelInnerElement >> text: aText [

	^ self explicitRequirement 
]
