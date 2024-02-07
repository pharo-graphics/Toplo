Class {
	#name : #ToThemeEditorThemeInfos,
	#superclass : #SpPresenter,
	#instVars : [
		'inspectButton',
		'saveButton',
		'themeClassInput',
		'notebook',
		'theme'
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
		  add: self saveButton expand: false;
		add: self inspectButton expand: false;
		  add: self notebook expand: true;
		  yourself
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
	notebook := SpNotebookPresenter new
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

	self halt.
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

{ #category : #'as yet unclassified' }
ToThemeEditorThemeInfos >> updatePresenter [

	self themeClassInput text: self theme class printString
]
