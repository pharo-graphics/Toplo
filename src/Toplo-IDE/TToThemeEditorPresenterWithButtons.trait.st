Trait {
	#name : #TToThemeEditorPresenterWithButtons,
	#traits : 'TToThemeEditorPresenterWithController + TToThemeEditorPresenterWithAddButton + TToThemeEditorPresenterWithRemoveButton',
	#classTraits : 'TToThemeEditorPresenterWithController classTrait + TToThemeEditorPresenterWithAddButton classTrait + TToThemeEditorPresenterWithRemoveButton classTrait',
	#category : #'Toplo-IDE-theme-editor-presenter'
}

{ #category : #'-- extensions-spec2 --' }
TToThemeEditorPresenterWithButtons >> buttonsLayout [

	^ (SpBoxLayout newHorizontal
				   spacing: 4;
				   add: self buttonAdd;
				   add: SpNullPresenter new;
				   add: self buttonRemove;
				   yourself)
]

{ #category : #'-- extensions-spec2 --' }
TToThemeEditorPresenterWithButtons >> updatePresenterOnlyButtons [

	self buttonAdd enabled: self controller isButtonAddEnabled.
	self buttonRemove enabled: self controller isButtonRemoveEnabled
]
