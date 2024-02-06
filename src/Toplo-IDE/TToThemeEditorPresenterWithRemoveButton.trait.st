Trait {
	#name : #TToThemeEditorPresenterWithRemoveButton,
	#instVars : [
		'buttonRemove'
	],
	#classTraits : 'TToThemeEditorPresenterWithController classTrait',
	#category : #'Toplo-IDE-theme-editor-presenter'
}

{ #category : #accessing }
TToThemeEditorPresenterWithRemoveButton >> actionRemoveButton [

	self shouldBeImplemented
]

{ #category : #accessing }
TToThemeEditorPresenterWithRemoveButton >> buttonRemove [

	buttonRemove ifNil: [
		buttonRemove := SpButtonPresenter new
			                label: self addLabel;
			                icon: (self iconNamed: #add);
			                action: [ self actionRemoveButton ];
			                help: self addHelp;
			                yourself ].
	^ buttonRemove
]

{ #category : #accessing }
TToThemeEditorPresenterWithRemoveButton >> removeHelp [

	^ 'Remove the selected item.'
]

{ #category : #accessing }
TToThemeEditorPresenterWithRemoveButton >> removeLabel [

	^ 'Remove'
]
