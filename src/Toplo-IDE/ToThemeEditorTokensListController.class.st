Class {
	#name : #ToThemeEditorTokensListController,
	#superclass : #Object,
	#traits : 'TToThemeEditorControllerWithButtons',
	#classTraits : 'TToThemeEditorControllerWithButtons classTrait',
	#instVars : [
		'theme',
		'tokens'
	],
	#category : #'Toplo-IDE-theme-editor-presenter-themeInfos'
}

{ #category : #adding }
ToThemeEditorTokensListController >> addToken [

	| tokenPresenter window |
	tokenPresenter := ToThemeEditorTokenCreator new.
	window := tokenPresenter asDialogWindow.
	window okAction: [ self tokens add: tokenPresenter makeNewToken ].
	window open.
	self updatePresenter
]

{ #category : #initialization }
ToThemeEditorTokensListController >> initialize [

	tokens := OrderedCollection new
]

{ #category : #testing }
ToThemeEditorTokensListController >> isButtonAddEnabled [

	^ true
]

{ #category : #testing }
ToThemeEditorTokensListController >> isButtonRemoveEnabled [

	^ self presenter tokensList selectedItem isNotNil
]

{ #category : #accessing }
ToThemeEditorTokensListController >> theme [

	^ theme
]

{ #category : #accessing }
ToThemeEditorTokensListController >> theme: aTheme [

	theme := aTheme.
	aTheme ifNil: [ tokens := OrderedCollection new ] ifNotNil: [ tokens := aTheme defaultTokenProperties asOrderedCollection. ].
	self updatePresenter
]

{ #category : #accessing }
ToThemeEditorTokensListController >> tokens [
	^ tokens
]

{ #category : #accessing }
ToThemeEditorTokensListController >> updatePresenter [

	self presenter tokensList items:
		(self tokens).
	self presenter updatePresenter
]
