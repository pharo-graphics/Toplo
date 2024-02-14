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
	tokenPresenter valueInput beForObject: self theme class.
	tokenPresenter valueInput text:
		('"self is theme class."').

	window := tokenPresenter asDialogWindow.
	window okAction: [ self tokens add: tokenPresenter makeNewToken ].
	window open.
	self updatePresenter
]

{ #category : #'as yet unclassified' }
ToThemeEditorTokensListController >> colorForToken: aToken [

	| sameTokens |
	sameTokens := self theme class superclass defaultTokenProperties
		              select: [ :t | t name = aToken name ].
	sameTokens ifEmpty: [ ^ Smalltalk ui theme successTextColor ].
	(sameTokens anySatisfy: [ :each | each value ~= aToken value ])
		ifTrue: [ ^ Smalltalk ui theme warningTextColor ]
		ifFalse: [ ^ Smalltalk ui theme textColor ]
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

{ #category : #adding }
ToThemeEditorTokensListController >> modifyToken: aToken [

	| tokenPresenter window |
	tokenPresenter := ToThemeEditorTokenCreator new.
	tokenPresenter nameInput text: aToken name.
	tokenPresenter valueInput beForObject: self theme class.
	tokenPresenter valueInput text:
		('"self is theme class."<r><1s><r>' expandMacrosWith:
			 aToken value printString).
	window := tokenPresenter asDialogWindow.
	window okAction: [
		| newToken |
		newToken := tokenPresenter makeNewToken.
		aToken name: newToken name.
		aToken value: newToken value ].
	window open.
	self updatePresenter
]

{ #category : #removing }
ToThemeEditorTokensListController >> removeToken: aToTokenProperty [ 

	self tokens remove: aToTokenProperty.
	self updatePresenter
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
