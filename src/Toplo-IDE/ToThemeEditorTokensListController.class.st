Class {
	#name : #ToThemeEditorTokensListController,
	#superclass : #Object,
	#traits : 'TToThemeEditorControllerWithButtons',
	#classTraits : 'TToThemeEditorControllerWithButtons classTrait',
	#instVars : [
		'theme'
	],
	#category : #'Toplo-IDE-theme-editor-presenter-themeInfos'
}

{ #category : #testing }
ToThemeEditorTokensListController >> isButtonAddEnabled [

	self flag: #TODO.
	^ false
]

{ #category : #testing }
ToThemeEditorTokensListController >> isButtonRemoveEnabled [

	self flag: #TODO.
	^ false
]

{ #category : #accessing }
ToThemeEditorTokensListController >> theme [

	^ theme
]

{ #category : #accessing }
ToThemeEditorTokensListController >> theme: aTheme [

	theme := aTheme.
	self updatePresenter
]

{ #category : #accessing }
ToThemeEditorTokensListController >> updatePresenter [

	self presenter tokensList items: self theme defaultTokenProperties.
	self presenter updatePresenter
]
