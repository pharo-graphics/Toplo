Trait {
	#name : #TToThemeEditorPresenterWithAddButton,
	#instVars : [
		'buttonAdd'
	],
	#classTraits : 'TToThemeEditorPresenterWithController classTrait',
	#category : #'Toplo-IDE-theme-editor-presenter'
}

{ #category : #accessing }
TToThemeEditorPresenterWithAddButton >> actionAddButton [

	self shouldBeImplemented
]

{ #category : #accessing }
TToThemeEditorPresenterWithAddButton >> addHelp [

	^ 'Add a new item.'
]

{ #category : #accessing }
TToThemeEditorPresenterWithAddButton >> addLabel [

 ^ 'Add'
]

{ #category : #accessing }
TToThemeEditorPresenterWithAddButton >> buttonAdd [

	buttonAdd ifNil: [
		buttonAdd := SpButtonPresenter new
			             label: self addLabel;
			             icon: (self iconNamed: #add);
			             action: [ self actionAddButton ];
			             help:
				             self addHelp;
			             yourself ].
	^ buttonAdd
]
