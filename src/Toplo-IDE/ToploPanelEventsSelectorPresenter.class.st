Class {
	#name : #ToploPanelEventsSelectorPresenter,
	#superclass : #ToploPanelWithButtonPresenter,
	#instVars : [
		'styleRule'
	],
	#category : #'Toplo-IDE-theme-editor-deprecated'
}

{ #category : #'as yet unclassified' }
ToploPanelEventsSelectorPresenter >> addNewLookEventListener [

	| newListener |
	self styleRule ifNil: [ ^ self ].
	newListener := ToPropertyWriter new
		               eventClass: ToInstallLookEvent;
		               yourself.
	self styleRule addLookEventListener: newListener.
	self panelContent items: self styleRule lookEventListeners.
	self panelContent selectItem: newListener.
	self buttonRemove enabled: true
]

{ #category : #'as yet unclassified' }
ToploPanelEventsSelectorPresenter >> addNewLookEventListenerTo: aToStyleRule [

	| newListener |
	newListener := ToPropertyWriter new
		               eventClass: ToInstallLookEvent;
		               yourself.
	aToStyleRule addLookEventListener: newListener.
	self panelContent items: aToStyleRule lookEventListeners.
	self panelContent selectItem: newListener.
	self buttonRemove enabled: true.
]

{ #category : #initialization }
ToploPanelEventsSelectorPresenter >> initializePresenters [

	super initializePresenters.
	panelContent := SpTablePresenter new whenSelectedItemChangedDo: [
		                :newLookEventsListener | self updatePresenter ].
	self buttonRemove action: [ self removeSelectedListener ].
	self buttonAdd action: [ self addNewLookEventListener ].
	self buttonAdd enabled: false.
	self buttonRemove enabled: false
]

{ #category : #'as yet unclassified' }
ToploPanelEventsSelectorPresenter >> panelName [

	^ 'Events selection'
]

{ #category : #'as yet unclassified' }
ToploPanelEventsSelectorPresenter >> removeSelectedListener [

	| listenerToRemove |
	self styleRule ifNil: [ ^ self ].
	listenerToRemove := self panelContent selectedItem.
	self styleRule removeLookEventListener: listenerToRemove.
	self updatePresenter
]

{ #category : #initialization }
ToploPanelEventsSelectorPresenter >> selectionChanged: aToLookEventsListener [

	self buttonRemove action: [
		self styleRule ifNil: [ ^ self ].
		self styleRule removeLookEventListener: aToLookEventsListener.
		self updatePresenter ]
]

{ #category : #initialization }
ToploPanelEventsSelectorPresenter >> styleRule [

	^ styleRule
]

{ #category : #'as yet unclassified' }
ToploPanelEventsSelectorPresenter >> styleRule: aToStyleRule [

	styleRule := aToStyleRule.
	
	self updatePresenter
]

{ #category : #accessing }
ToploPanelEventsSelectorPresenter >> theme: aToTheme [
	"Do nothing"

	
]

{ #category : #initialization }
ToploPanelEventsSelectorPresenter >> updatePresenter [

	self buttonAdd enabled: self styleRule isNotNil.
	self buttonRemove enabled: (self styleRule isNotNil and: [
			 self styleRule lookEventListeners isNotEmpty ]).

	self styleRule ifNil: [
		self panelContent items: {  }.
		^ self ].
	self panelContent items: self styleRule lookEventListeners.
	self styleRule lookEventListeners ifNotEmpty: [
		self panelContent selectIndex: 1 ].
	
]

{ #category : #initialization }
ToploPanelEventsSelectorPresenter >> updatePresenterOn: aLookEventListener [
self updatePresenter.
self panelContent selectItem: aLookEventListener.

]
