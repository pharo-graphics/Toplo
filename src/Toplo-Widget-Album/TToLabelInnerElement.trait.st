Trait {
	#name : #TToLabelInnerElement,
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #'t - label inner element' }
TToLabelInnerElement >> editorShortcutsIn: aLabel [

	^ self explicitRequirement 
]

{ #category : #'t - label inner element' }
TToLabelInnerElement >> newEditorIn: aLabel [

	^ self explicitRequirement 
]

{ #category : #'t - label inner element' }
TToLabelInnerElement >> text [

	^ self explicitRequirement 
]

{ #category : #'t - label inner element' }
TToLabelInnerElement >> text: aText [

	^ self explicitRequirement 
]
