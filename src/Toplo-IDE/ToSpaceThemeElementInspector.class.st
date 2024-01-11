Class {
	#name : #ToSpaceThemeElementInspector,
	#superclass : #SpPresenter,
	#instVars : [
		'notebook',
		'skinPage',
		'stampsPage',
		'tokensPage',
		'stylesPageProvider',
		'skinPageProvider'
	],
	#category : #'Toplo-IDE-space-theme-inspector'
}

{ #category : #layout }
ToSpaceThemeElementInspector >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: notebook expand: true;
		  add: self makeHelpLegend expand: false;
		  yourself
]

{ #category : #accessing }
ToSpaceThemeElementInspector >> element: aBlElement [

	| selectedPage |
	selectedPage := self notebook selectedPage.
	self notebook removeAll.
	self skinPageProvider element: aBlElement.
	self notebook addPage: self skinPage.
	self notebook selectPage: self skinPage.
	aBlElement ifNil: [ ^ self ].
	aBlElement toStyleStore stampIndex size > 0 ifTrue: [
		self stampsPage presenterProvider: [ aBlElement inspectionStamps ].
		self notebook addPage: self stampsPage.
		selectedPage = self stampsPage ifTrue: [
			self notebook selectPage: self stampsPage ] ].
	aBlElement toStyleStore tokenPropertyIndex size > 0 ifTrue: [
	self tokensPage presenterProvider: [ aBlElement inspectionTokens ].
	self notebook addPage: self tokensPage.
	selectedPage = self tokensPage ifTrue: [
		self notebook selectPage: self tokensPage ] ].
]

{ #category : #initialization }
ToSpaceThemeElementInspector >> initializePresenters [

	notebook := SpNotebookPresenter new.
	skinPage := SpNotebookPage
		            title: 'Skin'
		            provider: [ self skinPageProvider ].
	stampsPage := SpNotebookPage
		              title: 'Stamps'
		              provider: [ SpNullPresenter new ].
	tokensPage := SpNotebookPage
		              title: 'Tokens'
		              provider: [ SpNullPresenter new ]
]

{ #category : #'as yet unclassified' }
ToSpaceThemeElementInspector >> makeHelpLegend [

	| iconSet |
	iconSet := ToStyleSheetThemeExtensionSpec new.
	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add: iconSet skinAndStyleRuleIcon expand: false;
				   add: 'Selector is ok and rule is applied.';
				   yourself);
		  add: (SpBoxLayout newHorizontal
				   add: iconSet selectorOkButNotSkin expand: false;
				   add: 'Selector is ok but rule is not applied.';
				   yourself);
		  add: (SpBoxLayout newHorizontal
				   add: iconSet selectorKo expand: false;
				   add: 'Selector is ko.';
				   yourself);
		  yourself
]

{ #category : #accessing }
ToSpaceThemeElementInspector >> notebook [

	^ notebook
]

{ #category : #accessing }
ToSpaceThemeElementInspector >> skinPage [

	^ skinPage
]

{ #category : #accessing }
ToSpaceThemeElementInspector >> skinPageProvider [

	^ skinPageProvider
]

{ #category : #accessing }
ToSpaceThemeElementInspector >> skinPageProvider: anObject [

	skinPageProvider := anObject
]

{ #category : #accessing }
ToSpaceThemeElementInspector >> stampsPage [

	^ stampsPage
]

{ #category : #accessing }
ToSpaceThemeElementInspector >> tokensPage [

	^ tokensPage
]
