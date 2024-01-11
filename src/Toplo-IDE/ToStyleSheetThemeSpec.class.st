Class {
	#name : #ToStyleSheetThemeSpec,
	#superclass : #SpPresenter,
	#instVars : [
		'notebook',
		'toTheme',
		'pageStyleRules'
	],
	#category : #'Toplo-IDE'
}

{ #category : #layout }
ToStyleSheetThemeSpec >> defaultLayout [

	^ SpBoxLayout newHorizontal add: self notebook.
]

{ #category : #initialization }
ToStyleSheetThemeSpec >> initializePresenters [

	pageStyleRules := SpNotebookPage
		                  title: 'Style Rules'
		                  provider: [ self providerStyleRules ].
	notebook := SpNotebookPresenter new
		            addPage: pageStyleRules;
		            addPageTitle: 'Tokens'
		            provider: [ self providerTokens ];
		            addPageTitle: 'Writable Properties'
		            provider: [ self providerWritableProperties ];
		            yourself
]

{ #category : #layout }
ToStyleSheetThemeSpec >> notebook [
	^ notebook
]

{ #category : #initialization }
ToStyleSheetThemeSpec >> providerStyleRules [

	^ self toTheme inspectionStyleRules
]

{ #category : #initialization }
ToStyleSheetThemeSpec >> providerTokens [

	^ self toTheme inspectionTokens
]

{ #category : #initialization }
ToStyleSheetThemeSpec >> providerWritableProperties [

	^ self toTheme inspectionWritableProperties
]

{ #category : #accessing }
ToStyleSheetThemeSpec >> toTheme [

	^ toTheme
]

{ #category : #accessing }
ToStyleSheetThemeSpec >> toTheme: anObject [

	toTheme := anObject
]
