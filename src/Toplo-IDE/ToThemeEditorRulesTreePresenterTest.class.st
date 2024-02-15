Class {
	#name : #ToThemeEditorRulesTreePresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter',
		'theme',
		'controller',
		'observer'
	],
	#category : #'Toplo-IDE-theme-editor-presenter-rulesTree'
}

{ #category : #tests }
ToThemeEditorRulesTreePresenterTest >> controller [

	^ controller
]

{ #category : #tests }
ToThemeEditorRulesTreePresenterTest >> observer [

	^ observer
]

{ #category : #tests }
ToThemeEditorRulesTreePresenterTest >> presenter [

	^ presenter
]

{ #category : #running }
ToThemeEditorRulesTreePresenterTest >> setUp [

	super setUp.

	theme := ToStyleSheetTheme basicNew initialize addStyleRule:
		         ToStyleRule new.
	presenter := ToThemeEditorRulesTreePresenter new.

	observer := ToThemeEditorRuleObserverForTest new.

	controller := presenter controller.
	controller theme: theme.
	controller askBeforeRemove: false.
	controller addObserver: observer
]

{ #category : #tests }
ToThemeEditorRulesTreePresenterTest >> testActionAddButton [

	| currentSelection |
	self assert: self theme styleRules size equals: 1.
	self presenter buttonAdd click.
	self assert: self theme styleRules size equals: 2.
	currentSelection := self theme styleRules first.
	self presenter rulesTree selectPath: #( 1 1 ).
	self assert: currentSelection styleRules size equals: 0.
	self presenter buttonAdd click.
	self assert: currentSelection styleRules size equals: 1.
	self presenter rulesTree hasAdapter ifTrue: [
		self presenter rulesTree processDeferredActions.
		self
			assert: self presenter rulesTree selectedItem
			equals: currentSelection styleRules first ].
]

{ #category : #tests }
ToThemeEditorRulesTreePresenterTest >> testActionRemoveButton [

	self assert: self theme styleRules size equals: 1.
	self presenter rulesTree selectPath: #( 1 1 ).
	self presenter updatePresenterOnlyButtons.
	self presenter buttonRemove click.
	self assert: self theme styleRules size equals: 0.
	self assert: self observer count equals: 1
]

{ #category : #tests }
ToThemeEditorRulesTreePresenterTest >> testInitializePresenters [

	self assert: self presenter buttonAdd isEnabled.
	self deny: self presenter buttonRemove isEnabled.
	self assert: self presenter rulesTree selectedItem equals: self theme
]

{ #category : #tests }
ToThemeEditorRulesTreePresenterTest >> testSelectedRuleChanged [

	self assert: self observer styleRule equals: nil.
	self presenter rulesTree selectPath: #( 1 1 ).
	self
		assert: self observer styleRule
		equals: self theme styleRules first.
	self
		assert: self observer count
		equals: 1
]

{ #category : #tests }
ToThemeEditorRulesTreePresenterTest >> theme [

	^ theme
]
