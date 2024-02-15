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
		             addLookEventListener: ToPropertyWriter new;
		             addLookEventListener: ToPropertyWriter new;
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
ToThemeEditorEventsListenerListPresenterTest >> testActionAddButton [

	| previousEventListeners |
	self assert: self presenter eventListenersList items size equals: 2.
	previousEventListeners := self styleRule lookEventListeners copy.
	self presenter buttonAdd click.
	self assert: self presenter eventListenersList items size equals: 3.
	self assert: self styleRule lookEventListeners size equals: 3.
	self deny: (previousEventListeners includes: self presenter eventListenersList selectedItem )
]

{ #category : #tests }
ToThemeEditorEventsListenerListPresenterTest >> testActionRemoveButton [

	| eventListenerToRemove eventListenerKeep  |
	self assert: self presenter eventListenersList items size equals: 2.
	eventListenerToRemove := self styleRule lookEventListeners second.
	eventListenerKeep:= self styleRule lookEventListeners first.
	self presenter eventListenersList selectItem: eventListenerToRemove.
	self presenter buttonRemove click.
	self assert: self presenter eventListenersList items size equals: 1.
	self assert: self styleRule lookEventListeners size equals: 1.
	self assert: eventListenerKeep equals: self styleRule lookEventListeners first.
	self assert: eventListenerKeep equals: self presenter eventListenersList selectedItem.
]

{ #category : #tests }
ToThemeEditorEventsListenerListPresenterTest >> testInitializePresenters [

	self assert: self presenter buttonAdd isEnabled.
	self assert: self presenter buttonRemove isEnabled.
	self assert: self presenter eventListenersList selectedItem equals: self styleRule lookEventListeners first.
	self assert: self presenter eventListenersList items size equals: 2
]

{ #category : #tests }
ToThemeEditorEventsListenerListPresenterTest >> testSelectedEventListenerChanged [

	self assert: self observer eventListener equals: nil.
	self presenter eventListenersList selectIndex: 2 .
	self
		assert: self observer eventListener
		equals: (self styleRule lookEventListeners at: 2)
]
