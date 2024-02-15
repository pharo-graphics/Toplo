Class {
	#name : #ToThemeEditorTokenCreator,
	#superclass : #SpPresenter,
	#instVars : [
		'nameInput',
		'valueInput'
	],
	#category : #'Toplo-IDE-theme-editor-presenter-themeInfos'
}

{ #category : #layout }
ToThemeEditorTokenCreator >> defaultLayout [

	^ SpBoxLayout newVertical
		  spacing: 4;
		  add: 'name' expand: false;
		  add: self nameInput expand: false;
		  add: 'value' expand: false;
		  add: self valueInput expand: true;
		  yourself
]

{ #category : #'as yet unclassified' }
ToThemeEditorTokenCreator >> initializePresenters [

	nameInput := SpTextInputFieldPresenter new.
	valueInput  := SpCodePresenter new beForScripting.
]

{ #category : #'as yet unclassified' }
ToThemeEditorTokenCreator >> makeNewToken [

	| compiledValue |
	compiledValue := self valueInput
		                 evaluate: self valueInput text
		                 onCompileError: [ :err | ^ err pass ]
		                 onError: [ :err | ^ err pass ].
	^ ToTokenProperty
		  name: self nameInput text asSymbol
		  value: compiledValue
]

{ #category : #accessing }
ToThemeEditorTokenCreator >> nameInput [

	^ nameInput
]

{ #category : #accessing }
ToThemeEditorTokenCreator >> valueInput [

	^ valueInput
]
