Trait {
	#name : #TToThemeEditorPresenterWithApplyButton,
	#instVars : [
		'buttonApply'
	],
	#category : #'Toplo-IDE-theme-editor-presenter'
}

{ #category : #accessing }
TToThemeEditorPresenterWithApplyButton >> actionApplyButton [

	^ self shouldBeImplemented
]

{ #category : #accessing }
TToThemeEditorPresenterWithApplyButton >> applyHelp [

	^ 'Update the selected object with current value.'
]

{ #category : #accessing }
TToThemeEditorPresenterWithApplyButton >> applyLabel [

	^ 'Apply'
]

{ #category : #accessing }
TToThemeEditorPresenterWithApplyButton >> buttonApply [

	buttonApply ifNil: [
		buttonApply := SpButtonPresenter new
			             label: self applyLabel;
			             icon: (self iconNamed: #smallNew);
			             action: [ self actionApplyButton ];
			             help: self applyHelp;
			             yourself ].
	^ buttonApply
]

{ #category : #specs }
TToThemeEditorPresenterWithApplyButton >> panelName [

	^ self shouldBeImplemented
]

{ #category : #specs }
TToThemeEditorPresenterWithApplyButton >> topLayout [

	^ SpBoxLayout newHorizontal
		  spacing: 4;
		  add: (SpLabelPresenter new
				   label: self panelName;
				   displayBold: [ :t | true ];
				   yourself)
		  expand: true;
		  add: self buttonApply expand: false;
		  yourself
]
