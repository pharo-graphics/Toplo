Class {
	#name : #ToSpaceThemeElementViewPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'notebook',
		'skinPage',
		'stampsPage',
		'tokensPage',
		'skinPageProvider',
		'selectedElement'
	],
	#category : #'Toplo-IDE-space-theme-inspector'
}

{ #category : #layout }
ToSpaceThemeElementViewPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: notebook expand: true;
		  yourself
]

{ #category : #accessing }
ToSpaceThemeElementViewPresenter >> element [

	^ selectedElement
	
]

{ #category : #accessing }
ToSpaceThemeElementViewPresenter >> element: aBlElement [

	selectedElement := aBlElement.
	self updatePresenter
]

{ #category : #initialization }
ToSpaceThemeElementViewPresenter >> initializePresenters [

	notebook := SpNotebookPresenter new.
	skinPageProvider := ToStyleSheetThemeInspectorSpec new.
	skinPage := SpNotebookPage
		            title: 'Skin'
		            provider: [ SpNullPresenter new ].
	stampsPage := SpNotebookPage
		              title: 'Stamps'
		              provider: [ SpNullPresenter new ].
	tokensPage := SpNotebookPage
		              title: 'Tokens'
		              provider: [ SpNullPresenter new ]
]

{ #category : #accessing }
ToSpaceThemeElementViewPresenter >> notebook [

	^ notebook
]

{ #category : #accessing }
ToSpaceThemeElementViewPresenter >> skinPage [

	^ skinPage
]

{ #category : #accessing }
ToSpaceThemeElementViewPresenter >> stampsPage [

	^ stampsPage
]

{ #category : #accessing }
ToSpaceThemeElementViewPresenter >> tokensPage [

	^ tokensPage
]

{ #category : #initialization }
ToSpaceThemeElementViewPresenter >> updatePresenter [

	| selectedPage |
	selectedPage := self notebook selectedPage.
	self notebook removeAll.
	self skinPage presenterProvider: [ self element ifNil: [ SpLabelPresenter new label: 'No element selected'; yourself ]
			ifNotNil: [ :e | e inspectionSkin ] ].
	self notebook addPage: self skinPage.
	self notebook selectPage: self skinPage.
	self element ifNil: [ ^ self ].
	self element stampIndex ifNil: [ ^ self ].
	self element stampIndex size > 0 ifTrue: [
		self stampsPage presenterProvider: [ self element inspectionStamps ].
		self notebook addPage: self stampsPage.
		selectedPage = self stampsPage ifTrue: [
			self notebook selectPage: self stampsPage ] ].
	self element tokenPropertyIndex size > 0 ifTrue: [
		self tokensPage presenterProvider: [ self element inspectionTokens ].
		self notebook addPage: self tokensPage.
		selectedPage = self tokensPage ifTrue: [
			self notebook selectPage: self tokensPage ] ]
]
