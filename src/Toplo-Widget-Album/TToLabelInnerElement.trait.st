Trait {
	#name : 'TToLabelInnerElement',
	#category : 'Toplo-Widget-Album-Label',
	#package : 'Toplo-Widget-Album',
	#tag : 'Label'
}

{ #category : 'api - editor' }
TToLabelInnerElement >> editorShortcutsIn: aLabel [

	^ self explicitRequirement 
]

{ #category : 'api - editor' }
TToLabelInnerElement >> newEditorIn: aLabel [

	^ self explicitRequirement 
]

{ #category : 'api - text accessing' }
TToLabelInnerElement >> text [

	^ self explicitRequirement 
]

{ #category : 'api - text accessing' }
TToLabelInnerElement >> text: aText [

	^ self explicitRequirement 
]
