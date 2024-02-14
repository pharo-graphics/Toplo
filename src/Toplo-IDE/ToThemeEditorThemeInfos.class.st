Class {
	#name : #ToThemeEditorThemeInfos,
	#superclass : #SpPresenter,
	#instVars : [
		'inspectButton',
		'saveButton',
		'themeClassInput',
		'notebook',
		'theme',
		'tokensPresenter',
		'tokenAll',
		'tokenNo',
		'tokenNew'
	],
	#category : #'Toplo-IDE-theme-editor-presenter-themeInfos'
}

{ #category : #initialization }
ToThemeEditorThemeInfos >> add: aSpPresenter asNotebookPageNamed: aString [

	self notebook addPage: (SpNotebookPage title: aString provider: aSpPresenter)
]

{ #category : #accessing }
ToThemeEditorThemeInfos >> controller [

	^ self
]

{ #category : #layout }
ToThemeEditorThemeInfos >> defaultLayout [

	^ SpBoxLayout newVertical
		  spacing: 4;
		  add: (SpLabelPresenter new
				   label: 'Theme';
				   displayBold: [ :t | true ];
				   yourself)
		  expand: false;
		  add: self themeClassInput expand: false;
		  add: self tokenAll expand: false;
		 add: self tokenNew expand: false;
		 add: self tokenNo expand: false;
		  add: self saveButton expand: false;
		  add: self inspectButton expand: false;
		  add: self notebook expand: true;
		  yourself
]

{ #category : #initialization }
ToThemeEditorThemeInfos >> initializeNotebookPage [
		tokensPresenter := ToThemeEditorTokensListPresenter new.
	self  add: tokensPresenter asNotebookPageNamed: 'Tokens'
]

{ #category : #initialization }
ToThemeEditorThemeInfos >> initializePresenters [

	saveButton := SpButtonPresenter new
		              label: 'Save Changement';
		              icon: (self iconNamed: #smallSave);
		              action: [ self saveCurrentTheme ];
		              yourself.
	inspectButton := SpButtonPresenter new
		                 label: 'Inspect Theme';
		                 icon: (self iconNamed: #smallInspectIt);
		                 action: [ self theme inspect ];
		                 yourself.
	themeClassInput := SpTextInputFieldPresenter new.
	notebook := SpNotebookPresenter new.

	self initializeNotebookPage.

	tokenAll := SpRadioButtonPresenter new
		            label: 'Save all tokens in theme.';
		            yourself.
	tokenNew := SpRadioButtonPresenter new
		            label: 'Save only the tokens not in parents theme.';
		            yourself.
	tokenNo := SpRadioButtonPresenter new
		           label: 'Do not save the tokens.';
		           yourself.
	tokenAll associatedRadioButtons: { tokenNew . tokenNo }
]

{ #category : #layout }
ToThemeEditorThemeInfos >> inspectButton [

	^ inspectButton
]

{ #category : #initialization }
ToThemeEditorThemeInfos >> notebook [

	^ notebook
]

{ #category : #initialization }
ToThemeEditorThemeInfos >> saveButton [

	^ saveButton
]

{ #category : #'as yet unclassified' }
ToThemeEditorThemeInfos >> saveCurrentTheme [

	| model |
	model := ToThemeModel new
		         theme: self theme;
					tokens: self tokensPresenter controller tokens;
		         yourself.
	self tokenAll state ifTrue: [ model doNotHeritToken ].
	self tokenNew state ifTrue: [ model onlyDifferentTokens ].
	self tokenNo state ifTrue: [ model doHeritToken ].
	model compileOnCurrentTheme
]

{ #category : #'as yet unclassified' }
ToThemeEditorThemeInfos >> theme [

	^ theme

]

{ #category : #'as yet unclassified' }
ToThemeEditorThemeInfos >> theme: aToTheme [

	theme := aToTheme.
	self updatePresenter
]

{ #category : #initialization }
ToThemeEditorThemeInfos >> themeClassInput [

	^ themeClassInput
]

{ #category : #initialization }
ToThemeEditorThemeInfos >> tokenAll [
	^ tokenAll
]

{ #category : #initialization }
ToThemeEditorThemeInfos >> tokenNew [
	^ tokenNew
]

{ #category : #initialization }
ToThemeEditorThemeInfos >> tokenNo [
	^ tokenNo
]

{ #category : #accessing }
ToThemeEditorThemeInfos >> tokensPresenter [

	^ tokensPresenter
]

{ #category : #'as yet unclassified' }
ToThemeEditorThemeInfos >> updatePresenter [

	self themeClassInput text: self theme class printString.
	self tokensPresenter controller theme: self theme.
]
