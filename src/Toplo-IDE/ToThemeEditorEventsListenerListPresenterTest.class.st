Class {
	#name : #ToThemeEditorEventsListenerListPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'observer',
		'presenter',
		'styleRule',
		'controller'
	],
	#category : #'Toplo-IDE-theme-editor-presenter-eventListeners'
}

{ #category : #accessing }
ToThemeEditorEventsListenerListPresenterTest >> controller [

	^ controller
]

{ #category : #accessing }
ToThemeEditorEventsListenerListPresenterTest >> observer [

	^ observer
]

{ #category : #accessing }
ToThemeEditorEventsListenerListPresenterTest >> presenter [

	^ presenter
]

{ #category : #running }
ToThemeEditorEventsListenerListPresenterTest >> setUp [

	super setUp.

	styleRule := ToStyleRule new
		             addSkinEventListener: ToPropertyWriter new;
		             addSkinEventListener: ToPropertyWriter new;
		             yourself.
	presenter := ToThemeEditorEventsListenerListPresenter new.

	observer := ToThemeEditorEventListenerObserverForTest new.

	controller := presenter controller.
	controller selectedRuleChanged: styleRule.
	controller askBeforeRemove: false.
	controller addObserver: observer
]

{ #category : #accessing }
ToThemeEditorEventsListenerListPresenterTest >> styleRule [

	^ styleRule
]

{ #category : #tests }
ToThemeEditorEventsListenerListPresenterTest >> testActionAddButtonWithNilTheme [

	| previousEventListeners |
	controller theme: nil.
	self assert: self presenter eventListenersList items size equals: 2.
	previousEventListeners := self styleRule skinEventListeners copy.
	self presenter buttonAdd click.
	self assert: self presenter eventListenersList items size equals: 3.
	self assert: self styleRule skinEventListeners size equals: 3.
	self deny: (previousEventListeners includes:
			 self presenter eventListenersList selectedItem).
	self assert:
		(self presenter eventListenersList selectedItem isKindOf:
			 ToSkinEventAction)
]

{ #category : #tests }
ToThemeEditorEventsListenerListPresenterTest >> testActionAddButtonWithToStyleSheetTheme [

	| previousEventListeners |
	controller theme: ToStyleSheetTheme new.
	self assert: self presenter eventListenersList items size equals: 2.
	previousEventListeners := self styleRule skinEventListeners copy.
	self presenter buttonAdd click.
	self assert: self presenter eventListenersList items size equals: 3.
	self assert: self styleRule skinEventListeners size equals: 3.
	self deny: (previousEventListeners includes:
			 self presenter eventListenersList selectedItem).
	self assert:
		(self presenter eventListenersList selectedItem isKindOf:
			 ToPropertyWriter)
]

{ #category : #tests }
ToThemeEditorEventsListenerListPresenterTest >> testActionRemoveButton [

	| eventListenerToRemove eventListenerKeep  |
	self assert: self presenter eventListenersList items size equals: 2.
	eventListenerToRemove := self styleRule skinEventListeners second.
	eventListenerKeep:= self styleRule skinEventListeners first.
	self presenter eventListenersList selectItem: eventListenerToRemove.
	self presenter buttonRemove click.
	self assert: self presenter eventListenersList items size equals: 1.
	self assert: self styleRule skinEventListeners size equals: 1.
	self assert: eventListenerKeep equals: self styleRule skinEventListeners first.
	self assert: eventListenerKeep equals: self presenter eventListenersList selectedItem.
]

{ #category : #tests }
ToThemeEditorEventsListenerListPresenterTest >> testInitializePresenters [

	self assert: self presenter buttonAdd isEnabled.
	self assert: self presenter buttonRemove isEnabled.
	self assert: self presenter eventListenersList selectedItem equals: self styleRule skinEventListeners first.
	self assert: self presenter eventListenersList items size equals: 2
]

{ #category : #tests }
ToThemeEditorEventsListenerListPresenterTest >> testSelectedEventListenerChanged [

	self assert: self observer eventListener equals: nil.
	self presenter eventListenersList selectIndex: 2 .
	self
		assert: self observer eventListener
		equals: (self styleRule skinEventListeners at: 2)
]
